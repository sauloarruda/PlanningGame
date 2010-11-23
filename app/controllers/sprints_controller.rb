class SprintsController < ApplicationController
  
  def show
    @sprint = Sprint.find_by_id params[:id]
    @sprint.planned_story_points = 0 if @sprint.planned_story_points.nil?
  end
  
  def update
    @sprint = Sprint.find_by_id params[:id]
    @sprint.attributes = params[:sprint]
    params[:backlog_items].each do |item|
      @sprint.backlog_items << SprintBacklogItem.new(item)  
    end
    saved = false
    if (params[:commit] == t('save_plan'))
      saved = @sprint.save
    elsif (params[:commit] == t('save_and_execute_sprint'))
      save = @sprint.execute
    end
    puts @sprint.errors.to_json
    if saved
      redirect_to @sprint.project
    else
      render :action => "show"
    end
  end
  
  def product_backlog
    render :json => BacklogItem.all(params[:backlog_id]).to_json, :content_type => 'application/json' 
  end
  
  def sprint_backlog
    render :json => SprintBacklogItem.all(params[:project_id]) 
  end
  
end
