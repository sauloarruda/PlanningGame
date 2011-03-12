class AddSprintPoints < ActiveRecord::Migration
  def self.up
    add_column :sprints, :score, :integer
    Sprint.reset_column_information
    Sprint.all.each do |sprint|
      if sprint.executed?
        sprint.score = Score.calculate(sprint)
        sprint.save!
      end
    end
    
    add_column :projects, :score, :integer
    Project.reset_column_information
    Project.all.each do |project|
      score = 0
      project.sprints.each do |sprint|
        score = sprint.score if sprint.executed?
      end
      project.score = score
      project.save!
    end
  end

  def self.down
    remove_column :sprints, :points
  end
end
