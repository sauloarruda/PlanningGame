class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer :number

      t.integer :real_velocity
      t.integer :generated_defect_points
      t.integer :generated_technical_debt
      t.integer :accumulated_defect_points

      t.integer :planned_defect_points
      t.integer :planned_story_points

      t.references :project

      t.timestamps
    end
    
    add_index :sprints, :project_id
  end

  def self.down
    drop_table :sprints
  end
end
