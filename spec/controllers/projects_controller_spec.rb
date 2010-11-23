require 'spec_helper'

describe ProjectsController do

  fixtures :backlogs, :teams
  context "New Project" do
    before(:each) do
      get 'new'
    end
    
    it "should instantiate project object" do
      assigns[:project].should_not be_nil
    end
  end
  
  context "Create Project" do
    it "should save project and redirect to show action" do
      post 'create', :project => { :backlog_id => backlogs(:rede_social_arquitetos).id, 
        :team_id => teams(:jera).id } 
      response.should be_redirect
    end
    
    it "should validate required fields" do
      post 'create'
      assigns[:project].should have(2).errors
    end
  end
  
  context "Show Project" do
    fixtures :projects
    it "should instatiate ProjectReport" do
      get 'show', :id => projects(:jera_rsa)
      assigns[:project].should_not be_nil
    end
  end

end
