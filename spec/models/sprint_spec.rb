require 'spec_helper'

describe Sprint do
  fixtures :teams, :backlogs, :projects, :sprints, :backlog_themes, :backlog_items, :sprint_backlog_items

  before(:each) do
    @sprint = Sprint.find_by_id(sprints(:jera_rsa_1))
  end
  
  it "should belongs to Project" do
    @sprint.project.should == projects(:jera_rsa)
  end
  
  it "should add many BackLogItems and calculate sprint planned velocity" do
    # sprint alredy has 1 backlog item
    @sprint.backlog_items << SprintBacklogItem.new({
      :backlog_item => backlog_items(:visualizar_perfil_do_arquiteto), :priority => 0 })
    @sprint.backlog_items << SprintBacklogItem.new({
      :backlog_item => backlog_items(:buscar_arquiteto), :priority => 1 })
    @sprint.save!
    @sprint.planned_velocity.should == 21
  end
  
  it "should execute planning" do
    # TODO write cucumber spec for calculation rules
    @sprint.execute!
    @sprint.planned_velocity.should == 16
    @sprint.real_velocity.should == 18
    @sprint.defects.should == 2
    @sprint.technical_debt.should == 1
  end
end
