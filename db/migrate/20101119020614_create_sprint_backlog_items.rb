class CreateSprintBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :sprint_backlog_items do |t|
      t.references :sprint
      t.references :backlog_item
      
      t.integer :priority
      t.boolean :done, :default => false
      
      t.timestamps
    end
    
    add_index :sprint_backlog_items, :sprint_id
    add_index :sprint_backlog_items, :backlog_item_id
  end

  def self.down
    drop_table :sprint_backlog_items
  end
end
