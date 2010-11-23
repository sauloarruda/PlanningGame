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
    
    it "should validate presence of items and defect points" do
      @sprint = Sprint.new
      @sprint.valid?.should eql(false)
      @sprint.should have(1).error_on(:backlog_items)
      @sprint.should have(1).error_on(:planned_defect_points)
      @sprint.should have(1).error_on(:project)
    end
  
    it "should not execute not valid sprint" do
      @sprint = Sprint.new
      @sprint.execute.should eql(false)
      @sprint.real_velocity.should be_nil
    end
      
    it "should execute planning" do
      RandomSprintExecution.stub!(:roll_dice).and_return(4,8)
      @sprint.execute
      @sprint.planned_story_points.should eql(16)
      @sprint.real_velocity.should eql(18)
      @sprint.generated_defect_points.should eql(2)
      @sprint.generated_technical_debt.should eql(1)
    end
  end
  
  context "reporting alfa sprint1" do
    before(:each) do
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_1))
    end
    
    it "should get backlog's initial velocity" do
      @sprint.initial_velocity.should eql(backlogs(:rede_social_arquitetos).initial_velocity)
    end
    
    it "should calculate real story points" do
      @sprint.real_story_points.should eql(16)
    end
  
    it "should calculate positive balance" do
      @sprint.balance.should eql(2)
    end
    
    it "should not find previous sprint" do
      @sprint.previous.should be_nil
    end
    
    it "should calculate functional velocity" do
      @sprint.functional_velocity.should eql(18)
    end
    
    it "should calculate total defects" do
      @sprint.total_defects.should eql(1)
    end
    
    it "should calculate avaiable backlog points" do
      @sprint.avaiable_backlog_points.should eql(22)
    end
  
  end

  context "reporting alfa sprint 2" do
    before(:each) do
      @sprint = Sprint.find_by_id(sprints(:alfa_rsa_2))
    end
    
    it "should get previous sprint" do
      @sprint.previous.should eql(sprints(:alfa_rsa_1))
    end
    
    it "should get initial velocity of previous sprint" do
      @sprint.initial_velocity.should eql(18)
    end
    
    it "should calculate planned velocity" do
      @sprint.planned_velocity.should eql(19)
    end

    it "should calculate real story points" do
      @sprint.real_story_points.should eql(13)
    end

    it "should calculate actual technical debt" do
      @sprint.actual_technical_debt.should eql(1)
    end
    
    it "should calculate negative balance" do
      @sprint.balance.should eql(-5)
    end
    
    it "should calculate functional velocity" do
      @sprint.functional_velocity.should eql(15)
    end
    
    it "should calculate total defects" do
      @sprint.total_defects.should eql(3)
    end
    
    it "should not execute an already executed sprint" do
      pending "this don't work, please help"
      @sprint.execute.should eql(false)
      @sprint.should have(1).error_on(:real_velocity)
    end
    
  end
  
end
