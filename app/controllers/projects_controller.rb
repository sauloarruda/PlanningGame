# controller for create and show project report
class ProjectsController < ApplicationController  
  def new
    @project = Project.new
  end
  
  def create
    team = Team.find_or_create_by_name(:name => params[:team_name])
    @project = Project.new params[:project].merge(:team => team)
    if @project.save
      redirect_to :action => :show, :id => @project.id 
    else
      render :action => 'new'
    end
  end
  
  def show
    @project = ProjectReport.new params[:id]
    if @project.finished?
      flash[:message] = t('project_success') if @project.success?
      flash[:error] = t('project_fail') unless @project.success?
    end
  end
end
