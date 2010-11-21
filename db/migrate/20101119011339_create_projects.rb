class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.datetime :end_date
      t.references :team
      t.references :backlog

      t.timestamps
    end
    
    add_index :projects, :team_id
    add_index :projects, :backlog_id
  end

  def self.down
    drop_table :projects
  end
end
