require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ProjectsHelper. For example:
#
# describe ProjectsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ProjectsHelper do

  describe "avg" do
    it "should divide and format numbers" do
      helper.avg(5, 2).should eql("2,50")
    end
  end
  
end
