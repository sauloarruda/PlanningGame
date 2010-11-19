require 'spec_helper'

describe Project do
  fixtures :teams, :backlogs

  before(:each) do
    @time_now = Time.parse("Nov 18 2010")
    Time.stub!(:now).and_return(@time_now)
    @project = Project.create! :team => teams(:jera), :backlog => backlogs(:rede_social_arquitetos)
  end

  it "should create new project for team and backlog" do
    @project.start_date.should == @time_now
    @project.end_date.should be_nil
    @project.team.should == teams(:jera)
    @project.backlog.should == backlogs(:rede_social_arquitetos)
  end
  
  it "should create first sprint" do 
    @project.sprints.should have(1).record
    sprint = @project.sprints[0]
    sprint.number.should == 1
  end
end
