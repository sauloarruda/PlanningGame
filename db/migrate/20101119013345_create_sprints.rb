class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer :number
      t.integer :planned_velocity
      t.integer :real_velocity
      t.integer :technical_debt
      t.integer :defects
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
