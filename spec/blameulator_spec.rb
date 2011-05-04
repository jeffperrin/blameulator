require 'spec_helper'
# Fixture methods are in spec_helper.rb
describe Blameulator::CvsRlogResultsParser do
  describe "#parse" do
    context "one file committed" do
      before(:each) do
        parser = Blameulator::CvsRlogResultsParser.new
        @commits = parser.parse(single_valid_cvs_entry)
      end
      
      it "should have one commit" do
        @commits.size.should == 1
      end
      
      it "should have a comment" do
        @commits.first.comment.should == "Fixed a bug\n"
      end
      
      it "should have a date and should be offset to the local timezone -0600" do
        @commits.first.date.strftime("%Y/%m/%d %H:%M").should == "2011/03/21 11:47"
      end
      
      it "should have an author" do
        @commits.first.author.should == "cvsuser"
      end
      
      it "should have one file with a valid name and revision number" do
        @commits.first.files.size.should == 1
        @commits.first.files.first.name.should == "/u01/cvs/cvsroot/source/source_tree/Source/sql/Create.sql"
        @commits.first.files.first.author.should == "cvsuser"
        @commits.first.files.first.revision.should == "1.2024"
        @commits.first.files.first.date.strftime("%Y/%m/%d %H:%M").should == "2011/03/21 11:47"
      end
    end
    
    context "two files committed in the same checkin" do
      before(:each) do
        parser = Blameulator::CvsRlogResultsParser.new
        @commits = parser.parse(two_valid_cvs_entries_in_one_commit)
      end
      
      it "should have one commit" do
        @commits.size.should == 1
      end
      
      it "should have a comment" do
        @commits.first.comment.should == "Fixed a bug\n"
      end
      
      it "should have one file with a valid name and revision number" do
        @commits.first.files.size.should == 2
        @commits.first.files.first.name.should == "/u01/cvs/cvsroot/source/source_tree/Source/sql/Create.sql"
        @commits.first.files.last.name.should == "/u01/cvs/cvsroot/source/source_tree/Source/sql/Populate.sql"
      end
    end
    
    context "two files committed in different checkins" do
      before(:each) do
        parser = Blameulator::CvsRlogResultsParser.new
        @commits = parser.parse(two_valid_cvs_entries_in_two_separate_commits)
      end
      
      it "should have two commits" do
        @commits.size.should == 2
      end
      
      it "should have different comments for each commit" do
        @commits.first.comment.should == "Fixed a bug\n"
        @commits.last.comment.should == "Version Id\n"
      end
      
      it "should have one file in each commit" do
        @commits.first.files.size.should == 1
        @commits.last.files.size.should == 1
      end
    end
    
    context "one file committed in multiple checkins" do
      before(:each) do
        parser = Blameulator::CvsRlogResultsParser.new
        @commits = parser.parse(multiple_revisions_of_same_file_with_different_comment)
      end
      
      it "should have two commits" do
        @commits.size.should == 2
      end
      
      it "should different comments for each commit" do
        @commits.first.comment.should == "Foo bar\n"
        @commits.last.comment.should == "Version Id\n"
      end
    end

    context "one file committed in multiple checkins with the same comment" do
      before(:each) do
        parser = Blameulator::CvsRlogResultsParser.new
        @commits = parser.parse(multiple_revisions_of_same_file_with_same_comment)
      end
      
      it "should have two commits" do
        @commits.size.should == 2
      end
      
      it "should the same comment for each commit" do
        @commits.first.comment.should == "Version Id\n"
        @commits.last.comment.should == "Version Id\n"
      end
    end
    
  end
end