# represents a sprint backlog item for a project plan
class SprintBacklogItem < ActiveRecord::Base
  belongs_to :backlog_item
  belongs_to :sprint
  
  scope :all, lambda {|project| select("sprint_backlog_items.id, sprint_backlog_items.backlog_item_id, sprint_backlog_items.sprint_id, sprint_backlog_items.done").joins(:sprint).where('sprints.project_id' => project).order("sprints.number, sprint_backlog_items.priority") }
  scope :done, :conditions => {:done => true}
end
