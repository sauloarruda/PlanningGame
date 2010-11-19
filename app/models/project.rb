class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :backlog
  has_many :sprints

  before_save :create_first_sprint
  
  def create_first_sprint
    self.sprints << Sprint.new(:number => 1)
  end

  def start_date
    self.created_at
  end

end
