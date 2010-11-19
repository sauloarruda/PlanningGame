class CreateBacklogThemes < ActiveRecord::Migration
  def self.up
    create_table :backlog_themes do |t|
      t.string :title
      t.integer :priority
      t.references :backlog

      t.timestamps
    end
  end

  def self.down
    drop_table :backlog_themes
  end
end
