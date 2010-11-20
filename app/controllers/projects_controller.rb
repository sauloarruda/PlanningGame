class ProjectsController < ApplicationController
  
  def new
    # TODO get from user's session
    team = Team.find(:first)
    @backlogs = Backlog.find(:all).collect {|p| [ p.name, p.id ] }
    
    @project = Project.new :team => team
  end
  
  def create
    Project.create! params[:project]
  end
  
  def show
    @project = ProjectReport.new params[:id]
  end
  
end
