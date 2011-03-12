# represents an agile project plan and execution
class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :backlog
  has_many :sprints, :order => :number
  validates_presence_of :backlog, :team
  
  before_create :create_first_sprint
  
  def start_date
    self.created_at
  end
  
  def finish
    self.end_date = Time.now
    score = 0
    self.sprints.each do |sprint|
      score += sprint.score unless sprint.score.nil?
    end
    write_attribute(:score, score)
    self.save!
  end
  
  def finished?
    not self.end_date.nil?
  end
  
  def success?
    self.sprints.last.avaiable_backlog_points == 0
  end
  
  private
  def create_first_sprint
    self.sprints.build :number => 1, :accumulated_defect_points => 0, :planned_defect_points => 0, :planned_story_points => 0
  end
end
