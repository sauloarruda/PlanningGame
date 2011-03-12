class Score
  
  RATIO = {
    :planned_defect_points => 10,
    :planned_story_points => 20,
    :real_story_points => 20,
    :total_defects => -30,
    :generated_technical_debt => -20
  }
  
  def self.calculate(sprint)
    points = 0
    RATIO.keys.each do |key|
      eval("points += sprint.#{key.to_s} * #{RATIO[key]} rescue 0")
    end
    points
  end
  
end