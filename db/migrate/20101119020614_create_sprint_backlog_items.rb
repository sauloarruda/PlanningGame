class CreateSprintBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :sprint_backlog_items do |t|
      t.integer :priority
      t.references :sprint
      t.references :backlog_item
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sprint_backlog_items
  end
end
