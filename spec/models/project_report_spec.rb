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
  
  def assert_field(field, expected_values, expected_total)
    values = []
    @project.sprints.each do |sprint|
      eval("values << sprint.#{field}")
    end
    values.should eql(expected_values)
    eval("@project.total_#{field}.should eql(expected_total)")
  end

end
