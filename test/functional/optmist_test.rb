require "test/unit"
require "rubygems"
require "selenium/client"

class OptmistTest < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "http://0.0.0.0:3000/",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
  end
  
  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
  
  def test_execute
    create_new_project
    click("link=#1") # 1st iteration
    
    until not run_iteraction
      puts "# running"
    end
  end
  
  private 
  
    WAIT_TIME = 30000
    
    def create_new_project
      @selenium.open "/"
      click("project_submit")
    end
  
    def run_iteraction
      initial_velocity = @selenium.get_value("id=initial_velocity").to_i
      begin
        @selenium.select "sprint_planned_defect_points", (@selenium.get_select_options("id=sprint_planned_defect_points").size - 1)
      rescue 
      end
      planned_velocity = @selenium.get_value("id=planned_velocity").to_i
      while planned_velocity < initial_velocity
        add_first_item rescue break
        planned_velocity = @selenium.get_value("id=planned_velocity").to_i
      end
      begin
        click "//input[@id='sprint_submit' and @name='commit' and @value='Gravar e Executar Sprint']"
        click "//input[@id='sprint_submit' and @name='commit']"
      rescue
        click "link=< Voltar ao Projeto"
        return false
      end
      true
    end

    def add_first_item
      @selenium.select "product_backlog_select", "index=0"
      @selenium.click "//button[@onclick='add_item(); return false']"
    end
    
    def click(id)
      @selenium.click id
      @selenium.wait_for_page_to_load WAIT_TIME
    end
end

