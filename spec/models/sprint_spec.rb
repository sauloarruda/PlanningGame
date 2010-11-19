require 'spec_helper'

describe Sprint do
  fixtures :teams, :backlogs, :projects, :sprints, :backlog_themes, :backlog_items, :sprint_backlog_items

  context "planning sprint" do
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
      @sprint.planned_story_points.should eql(21)
    end
  
    it "should execute planning" do
      # TODO write cucumber spec for calculation rules
      @sprint.execute!
      @sprint.planned_story_points.should eql(16)
      @sprint.real_velocity.should eql(18)
      @sprint.generated_defects.should eql(2)
      @sprint.generated_technical_debt.should eql(1)
    end
  end
  
  context "reporting alfa sprint1" do
    before(:each) do
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_1))
    end
    
    it "should calculate real story points" do
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_1))
      @sprint.real_story_points.should eql(16)
    end
  
    it "should calculate positive balance" do
      pending "todo this test"
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_1))
      @sprint.balance.should eql(2)
    end
    
    it "should not find previous sprint" do
      @sprint.previous.should be_nil
    end
  
  end

  context "reporting alfa sprint 2" do
    before(:each) do
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_2))
    end
    
    it "should get previous sprint" do
      @sprint.previous.should eql(sprints(:alfa_rsa_1))
    end
    
    it "should calculate planned velocity" do
      @sprint.planned_velocity.should eql(19)
    end
    
    
  end
  
end
