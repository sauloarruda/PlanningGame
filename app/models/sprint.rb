# represents a project's sprint
class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :backlog_items, :class_name => "SprintBacklogItem", :foreign_key => "sprint_id"
  validates_size_of :backlog_items, :minimum => 1
  validates_presence_of :planned_defect_points, :project
  
  before_save :calculate_planned_velocity

  # velocity of previous sprint ou backlog's initial velocity if first
  def initial_velocity 
    if self.number == 1
      self.project.backlog.initial_velocity 
    else
      self.previous.real_velocity rescue nil
    end
  end
  
  # sum of realized story points from done sprint backlog items
  def real_story_points
    # if there are not done itens, returns null
    backlog_items = self.backlog_items
    if backlog_items.length == 0
      nil
    else
      points = 0
      backlog_items.each do |item|
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
      previous.generated_technical_debt rescue nil
    end
  end
  
  # total sprint defects is the accumlated minus planned plus generated
  def total_defects
    (self.accumulated_defect_points - self.planned_defect_points) + generated_defect_points rescue nil
  end

  # previous sprint or null if first, search sprint by number
  def previous
    sprints = self.project.sprints
    index = Sprint::sprint_index(self.number, sprints)
    sprints[index-1] unless index.nil? or index == 0
  end
    
  # the diference between planned and real, if positive, there was unused points, if negative, the
  # planned was higher than real and not all backlog itens where done
  def balance 
    planned_velocity = self.planned_velocity
    real_velocity = self.real_velocity
    if (real_velocity.nil?)
      nil
    elsif (real_velocity > planned_velocity)
      real_velocity - planned_velocity
    else
      self.real_story_points + self.planned_defect_points + self.actual_technical_debt - planned_velocity
    end
  end
  
  def avaiable_backlog_points
    sum = BacklogItem.select("sum(backlog_items.points) as points").where("backlog_items.id not in (select s.backlog_item_id from sprint_backlog_items s where s.sprint_id=? and done=true)", self.id).first
    sum[:points]
  end
  
  
  def execute
    if (self.valid?)
      unless (self.real_velocity.nil?)
        self.errors.add(:real_velocity, "already was executed")
        puts self.errors.to_json
        return false
      end
      data = RandomSprintExecution.random_data
      self.real_velocity = self.initial_velocity + (data[:velocity])
      self.generated_defect_points = data[:defects]
      self.accumulated_defect_points += self.generated_defect_points
      self.generated_technical_debt = RandomSprintExecution.technical_debt(self.accumulated_defect_points)
      return self.save
    end
    return false
  end
  
  private
    def calculate_planned_velocity
      self.planned_story_points = 0
      self.backlog_items.each do |item|
        self.planned_story_points += item.backlog_item.points
      end
    end
    
    def Sprint::sprint_index(number, sprints)
      index = nil
      sprints.each do |sprint|
        if (number == sprint.number)
          index = number - 1
          break
        end
      end
      index
    end
  
end
