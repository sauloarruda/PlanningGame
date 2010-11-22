# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PlanningGame::Application.initialize!

# Exclude class name from json
ActiveRecord::Base.include_root_in_json = false