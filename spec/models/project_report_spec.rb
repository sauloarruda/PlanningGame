require 'spec_helper'

describe ProjectReport do
  fixtures :teams, :backlogs, :projects, :sprints, :backlog_themes, :backlog_items, :sprint_backlog_items
  
  before(:each) do
    @project = ProjectReport.new(projects(:alfa_rsa))
  end
  
  it "should get project name" do
    @project.name.should eql(backlogs(:rede_social_arquitetos).name)
  end
  
  it "should get 8 sprints" do
    @project.sprints.length.should eql(8)
  end
  
  it "should get initial velociy row" do
    assert_field("initial_velocity", [20, 18, 16, nil, nil, nil, nil, nil], 54)
  end
  
  it "should get accumulated defects field" do
    assert_field("accumulated_defect_points", [0, 1, 3, nil, nil, nil, nil, nil], 4)
  end
  
  it "should get actual technical debt field" do
    assert_field("actual_technical_debt", [0, 1, 2, nil, nil, nil, nil, nil], 3)
  end

  it "should get planned defect points field" do
    assert_field("planned_defect_points", [0, 0, nil, nil, nil, nil, nil, nil], 0)
  end

  it "should get planned story points field" do
    assert_field("planned_story_points", [16, 18, nil, nil, nil, nil, nil, nil], 34)
  end

  it "should get planned velocity field" do
    assert_field("planned_velocity", [16, 19, nil, nil, nil, nil, nil, nil], 35)
  end

  it "should get real velocity field" do
    assert_field("real_velocity", [18, 16, nil, nil, nil, nil, nil, nil], 34)
  end

  it "should get functional velocity field" do
    assert_field("functional_velocity", [18, 15, nil, nil, nil, nil, nil, nil], 33)
  end

  it "should get real story points field" do
    assert_field("real_story_points", [16, 13, nil, nil, nil, nil, nil, nil], 29)
  end
  
  it "should get balance field" do
    assert_field("balance", [2, -5, nil, nil, nil, nil, nil, nil], -3)
  end

  it "should get generated defect points field" do
    assert_field("generated_defect_points", [1, 2, nil, nil, nil, nil, nil, nil], 3)
  end
  
  it "should get total defects field" do
    assert_field("total_defects", [1, 3, nil, nil, nil, nil, nil, nil], 4)
  end
  
  
  
  def assert_field(field, expected_values, expected_total)
    values = []
    @project.sprints.each do |sprint|
      eval("values << sprint.#{field}")
    end
    values.should eql(expected_values)
    eval("@project.total_#{field}.should eql(expected_total)")
  end

end
