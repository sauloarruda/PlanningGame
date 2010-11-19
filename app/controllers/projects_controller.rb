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
    @project = Project.find_by_id params[:id]
    @total_velocity = @project.backlog.initial_velocity
    @total_defects = 0
    @technical_debt = 0
  end
  
end
