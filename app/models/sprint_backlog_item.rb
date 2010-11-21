# represents a sprint backlog item for a project plan
class SprintBacklogItem < ActiveRecord::Base
  belongs_to :backlog_item
  belongs_to :sprint
end
