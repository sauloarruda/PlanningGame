class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer :number

      t.integer :real_velocity
      t.integer :generated_defects
      t.integer :technical_debt

      t.integer :defects_points
      t.integer :story_points

      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
