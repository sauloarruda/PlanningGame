# controller for create and show project report
class ProjectsController < ApplicationController  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new params[:project]
    if @project.save
      redirect_to :action => :show, :id => @project.id 
    else
      render :action => 'new'
    end
  end
  
  def show
    @project = ProjectReport.new params[:id]
  end
end
