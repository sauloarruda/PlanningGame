class TeamsController < ApplicationController
  
  def show
    @team = Team.find_by_name(params[:id])
  end
  
end
