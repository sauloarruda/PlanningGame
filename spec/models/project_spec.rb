require 'spec_helper'

describe Project do
  fixtures :teams

  it "should create new project for team" do
    @time_now = Time.parse("Nov 18 2010")
    Time.stub!(:now).and_return(@time_now)
      
    project = Project.create! :team => teams(:jera)
    project.start_date.should == @time_now
    project.end_date.should be_nil
    project.team.should == teams(:jera)
  end
end
