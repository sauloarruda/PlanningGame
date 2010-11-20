class ProjectReport
  
  attr_reader :project, :sprints
  
  # TODO configure with metaprogramming using EXPOSED_FIELDS
  attr_accessor :total_initial_velocity, :total_accumulated_defect_points, :total_actual_technical_debt, :total_planned_defect_points
  
  def initialize(project_id)
    @project = Project.find_by_id(project_id)
    initialize_totals
    create_sprints
  end
  
  def name
    @project.backlog.name
  end

  ProjectReport::EXPOSED_FIELDS = [:initial_velocity, :accumulated_defect_points, :actual_technical_debt,
    :planned_defect_points]

private
  def initialize_totals
    ProjectReport::EXPOSED_FIELDS.each do |method_name|
      eval("@total_#{method_name} = 0")
    end
  end
  
  def create_sprints
    @sprints = []
    0.upto(@project.backlog.max_sprints-1) do |n|
      sprint_report = SprintReport.new(self, n)
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

class SprintReport
  def initialize(project_report, n)
    @project_report = project_report
    project = project_report.project
    if (project.sprints.length > n)
      @sprint = project.sprints[n]
    else
      @sprint = Sprint.new :project => project, :number => n + 1
    end  
  end
  
  ProjectReport::EXPOSED_FIELDS.each do |method_name|
    send :define_method, method_name do
      eval("@sprint." + method_name.to_s)
    end
  end
  
    
end