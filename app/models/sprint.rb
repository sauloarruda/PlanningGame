class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :backlog_items, :class_name => "SprintBacklogItem", :foreign_key => "sprint_id"
  
  before_save :calculate_planned_velocity

  # velocity of previous sprint ou backlog's initial velocity if first
  def initial_velocity 
    if self.number == 1
      self.project.backlog.initial_velocity 
    else
      (self.previous.nil?) ? nil : self.previous.real_velocity 
    end
  end
  
  # sum of realized story points from done sprint backlog items
  def real_story_points
    # if there are not done itens, returns null
    if self.backlog_items.length == 0
      nil
    else
      points = 0
      self.backlog_items.each do |item|
        points += item.backlog_item.points if item.done?
      end
      points
    end
  end
  
  # part of real velocity that may be used for story points
  def functional_velocity
    # in case of one of values is null, may to return null
    self.real_velocity - (self.planned_defect_points + self.actual_technical_debt) rescue nil
  end
  
  # total planned velocity is sum of planned story points, planned defects and previous sprint's technical debt
  def planned_velocity
    # in case of one of values is null, may to return null
    self.actual_technical_debt + self.planned_story_points + self.planned_defect_points rescue nil 
  end

  # accumulate technical deft from last sprint, return 0 if first
  def actual_technical_debt
    if self.number == 1
      0
    else
      (previous.nil?) ? nil : previous.generated_technical_debt
    end
  end
  
  # total sprint defects is the accumlated minus planned plus generated
  def total_defects
    (self.accumulated_defect_points - self.planned_defect_points) + generated_defect_points rescue nil
  end

  # previous sprint or null if first, search sprint by number
  def previous
    index = nil
    self.project.sprints.each do |s|
       if (s.number == self.number)
         index = s.number - 1
         break
       end
    end
    self.project.sprints[index-1] unless index.nil? or index == 0
  end
  
  # the diference between planned and real, if positive, there was unused points, if negative, the
  # planned was higher than real and not all backlog itens where done
  def balance 
    if (self.real_velocity.nil?)
      nil
    elsif (self.real_velocity > self.planned_velocity)
      self.real_velocity - self.planned_velocity
    else
      self.real_story_points + self.planned_defect_points + self.actual_technical_debt - self.planned_velocity
    end
  end
  
  def execute!
    self.real_velocity = 18
    self.generated_defect_points = 2
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
