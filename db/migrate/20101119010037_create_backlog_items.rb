class CreateBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :backlog_items do |t|
      t.string :title
      t.integer :points
      t.references :backlog_theme
      
      t.timestamps
    end
  end

  def self.down
    drop_table :backlog_items
  end
end
