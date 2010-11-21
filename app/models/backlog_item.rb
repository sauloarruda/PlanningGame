# represents a backlog item, typically an user story 
class BacklogItem < ActiveRecord::Base
  belongs_to :backlog_theme
end
