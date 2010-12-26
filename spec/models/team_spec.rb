require 'spec_helper'

describe Team do
  fixtures :teams
  
  it "should find by id" do
    team = Team.find_by_id(teams(:jera))
    team.name.should == 'Instrutor'
  end
end
