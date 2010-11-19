require 'spec_helper'

describe Sprint do
  fixtures :teams, :backlogs, :projects, :sprints
  
  it "should belongs to Project" do
    sprint = Sprint.find_by_id(sprints(:jera_rsa_1))
    sprint.project.should == projects(:jera_rsa)
  end
end
