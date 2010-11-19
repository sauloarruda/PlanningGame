class CreateSprintBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :sprint_backlog_items do |t|
      t.references :sprint
      t.references :backlog_item
      
      t.integer :priority
      t.boolean :done
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sprint_backlog_items
  end
end
