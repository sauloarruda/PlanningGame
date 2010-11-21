# controller for create and show project report
class ProjectsController < ApplicationController
  
  def new
    load_data
    @project = Project.new
  end
  
  def create
    @project = Project.new params[:project]
    if @project.save
      redirect_to :action => :show, :id => @project.id 
    else
      load_data
      render :action => 'new'
    end
  end
  
  def show
    @project = ProjectReport.new params[:id]
  end

  private 
    def load_data 
      @backlogs = Backlog.find(:all).collect {|backlog| [ backlog.name, backlog.id ] }
      @teams = Team.find(:all).collect {|team| [team.name, team.id] }
    end
  
end
