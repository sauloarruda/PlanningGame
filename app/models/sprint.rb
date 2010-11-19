class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :backlog_items, :class_name => "SprintBacklogItem", :foreign_key => "sprint_id"
  
  before_save :calculate_planned_velocity
  
  def real_story_points
    points = 0
    self.backlog_items.each do |item|
      points += item.backlog_item.points if item.done?
    end
    points
  end
  
  # total planned velocity is sum of planned story points, planned defects and previous sprint's technical debt
  def planned_velocity
    previous_sprint = self.previous
    technical_debt = (previous_sprint.nil?) ? 0 : previous_sprint.generated_technical_debt
    technical_debt + self.planned_story_points + self.planned_defect_points
  end

  # previous sprint or null if first
  def previous
    index = self.project.sprints.find_index(self)
    self.project.sprints[index-1] unless index==0
  end
  
  def balance 
    
  end
  
  def execute!
    self.real_velocity = 18
    self.generated_defects = 2
    self.generated_technical_debt = 1
    self.save!
  end
  
  private
    def calculate_planned_velocity
      self.planned_story_points = 0
      self.backlog_items.each do |item|
        self.planned_story_points += item.backlog_item.points
      end
    end
  
end
