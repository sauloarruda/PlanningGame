class CreateBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :backlog_items do |t|
      t.string :title
      t.integer :points
      t.integer :priority
      t.references :backlog_theme
      
      t.timestamps
    end
    
    add_index :backlog_items, :backlog_theme_id
  end

  def self.down
    drop_table :backlog_items
  end
end
