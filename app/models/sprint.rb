class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :backlog_items, :class_name => "SprintBacklogItem", :foreign_key => "sprint_id"
  
  before_save :calculate_planned_velocity
  
  def calculate_planned_velocity
    self.planned_velocity = 0
    self.backlog_items.each do |item|
      self.planned_velocity += item.backlog_item.points
    end
  end
  
  def execute!
    self.real_velocity = 18
    self.defects = 2
    self.technical_debt = 1
    self.save!
  end
end
