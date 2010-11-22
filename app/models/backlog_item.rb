# represents a backlog item, typically an user story 
class BacklogItem < ActiveRecord::Base
  belongs_to :backlog_theme
  has_many :sprint_backlog_items
  scope :all, lambda {|backlog| select("backlog_items.id, backlog_items.title, backlog_items.points, backlog_themes.title as theme").joins(:backlog_theme).where('backlog_themes.backlog_id' => backlog).order("backlog_themes.priority DESC, backlog_items.priority") }
end
