# delegator for project in project report that builds all totals and correct columns and rows based on a project
class ProjectReport
  
  attr_reader :project, :sprints
  
  # fields to be exposed by SprintReport delegator
  ProjectReport::EXPOSED_FIELDS = [:initial_velocity, :accumulated_defect_points, :actual_technical_debt,
    :planned_defect_points, :planned_story_points, :planned_velocity, :real_velocity, :functional_velocity,
    :real_story_points, :balance, :generated_defect_points, :total_defects, :generated_technical_debt]
    
  def initialize(project_id)
    @project = Project.find_by_id(project_id)
    initialize_totals
    create_sprints
  end
  
  def name
    @project.backlog.name
  end
  
  def team
    @project.team.name
  end
  
  def sprints_length 
    @project.sprints.length
  end

private
  def initialize_totals
    ProjectReport::EXPOSED_FIELDS.each do |method_name|
      eval("@total_#{method_name} = 0")
      eval("self.class.class_eval { attr_accessor :total_#{method_name} }")
    end
  end
  
  def create_sprints
    @sprints = []
    0.upto(@project.backlog.max_sprints-1) do |number|
      sprint_report = SprintReport.new(self, number)
      @sprints << calculate_total(sprint_report)
    end
  end
  
  def calculate_total(sprint_report)
    ProjectReport::EXPOSED_FIELDS.each do |method_name|
      eval("@total_#{method_name} += sprint_report.#{method_name} unless sprint_report.#{method_name}.nil?")
    end
    sprint_report
  end

end

# delegator for sprint in project report
class SprintReport
  attr_reader :sprint
  def initialize(project_report, number)
    @project_report = project_report
    project = project_report.project
    sprints = project.sprints
    if (sprints.length > number)
      @sprint = sprints[number]
    else
      @sprint = Sprint.new :project => project, :number => number + 1
    end  
  end
  
  def number 
    @sprint.number
  end
  
  ProjectReport::EXPOSED_FIELDS.each do |method_name|
    send :define_method, method_name do
      eval("@sprint." + method_name.to_s)
    end
  end
  
end