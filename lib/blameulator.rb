require 'erb'
require 'date'
require 'fileutils'

module Blameulator
  class CvsCommit
    attr_accessor :author, :comment, :files
    def initialize
      @files = []
      @author = ''
    end
    def date
      files.first.date
    end
  end

  class CvsRevision
    attr_accessor :name, :revision, :author, :previous_revision, :date, :comment
    def initialize
      @comment = ''
      @author = ''
    end
    def commit_key
      author + comment + date.to_s
    end
  end

  class CvsRlogResultsParser
    def initialize()
      @commits = {}
    end

    def parse(results)
      #split up lines by file updated in cvs
      results.split(/^====/).each do |entry|
        file_name = ''
        revisions = []
        next_line_is_comment = false

        #parse each line in for the file, creating revisions as we find them
        entry.each_line do |line|
          if line =~ /^----/
            next_line_is_comment = false
          elsif next_line_is_comment
            revisions.last.comment += line
          elsif line =~ /^RCS file/
            file_name = line.sub("RCS file: ", "").sub(",v\n", "")
          elsif line =~ /^revision/
            rev = CvsRevision.new
            rev.name = file_name
            rev.revision = line[9..14]
            revisions << rev
          elsif line =~ /^date/
            d = line[6..21]
            #cvs log gives us times in utc. This converts to the local time.
            revisions.last.date = Time.utc(d[0..3].to_i, d[5..6].to_i, d[8..9].to_i, d[11..12].to_i, d[14..15]).getlocal
            before = "author: "
            after = ";"
            revisions.last.author = line.scan(/#{before}(.*?)#{after}/).flatten.first
            next_line_is_comment = true
          end
        end

        #find or create a Commit based on the checkin comments. Add each Revision to the Commit
        revisions.each do |revision|
          commit = @commits[revision.commit_key]
          if commit.nil?
            commit = CvsCommit.new
            commit.comment = revision.comment
            commit.author = revision.author
            @commits[revision.commit_key] = commit
          end
          commit.files << revision
        end

      end

      @commits.values.sort {|x,y| x.date <=> y.date }
    end
  end

  class CvsRlogCommand
    attr_accessor :cvs_module, :cvs_root
    def run
      `cvs -Q rlog -N -S -d "#{(Date.today - 1).to_s} < #{(Date.today ).to_s}" #{cvs_module}`
    end
  end
end

class HtmlOutputTask
  def initialize(out, rlog, commits)
    @out = out
    @commits = commits
    @rlog = rlog
  end

  def run
    template = render_template("#{template_dir}/changelog_template.html.erb", @rlog, @commits)
    File.open("#{File.expand_path(@out)}", 'w'){|f| f.write(template)}
  end

  def template_dir
    File.dirname(__FILE__)
  end

  private
    def render_template(template, rlog, commits=[])
      template = ERB.new File.new(template).read
      template.result(binding)
    end
end

def generate_changelog_into(directory, options={})
  rlog = Blameulator::CvsRlogCommand.new()
  yield rlog
  results = rlog.run
  commits = Blameulator::CvsRlogResultsParser.new.parse(results)
  HtmlOutputTask.new(directory, rlog, commits).run;
end
