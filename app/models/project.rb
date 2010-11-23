# represents an agile project plan and execution
class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :backlog
  has_many :sprints, :order => :number
  validates_presence_of :backlog, :team

  before_save :create_first_sprint
  
  def create_first_sprint
    self.sprints << Sprint.new(:number => 1, :accumulated_defect_points => 0, :planned_defect_points => 0)
  end

  def start_date
    self.created_at
  end
end
