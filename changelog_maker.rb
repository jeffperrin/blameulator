require 'rubygems'
require 'blameulator'

generate_changelog_into "~/adirectory/#{Time.new.strftime("%m-%d-%Y")}.html" do |cvs|
  cvs.cvs_module    = "source_tree"
  cvs.cvs_root      = ":pserver:cvsuser@server:/cvs/cvsroot/source"
end