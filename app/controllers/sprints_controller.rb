class SprintsController < ApplicationController
  
  def show
    @sprint = Sprint.find params[:id]
    @sprint.planned_story_points ||= 0
  end
  
  def update
    @sprint = Sprint.find params[:id]
    if (@sprint.real_velocity.nil?)
      @sprint.attributes = params[:sprint]
      @sprint.backlog_items.clear
      params[:backlog_items].each do |priority, item|
        @sprint.backlog_items << SprintBacklogItem.new(:backlog_item_id => item[:backlog_item_id],
          :priority => priority)  
      end unless (params[:backlog_items].nil?)
      logger.debug @sprint.backlog_items.to_json
      saved = false
      if (params[:commit] == t('save_plan'))
        saved = @sprint.save
      elsif (params[:commit] == t('save_and_execute_sprint'))
        saved = @sprint.execute
      end
      flash[:message] = t('saved_successfuly') if (saved) 
    end
    redirect_to :action => "show"
  end
  
  def product_backlog
    render :json => BacklogItem.all(params[:backlog_id]).to_json, :content_type => 'application/json' 
  end
  
  def sprint_backlog
    render :json => SprintBacklogItem.all(params[:project_id]) 
  end
  
end
