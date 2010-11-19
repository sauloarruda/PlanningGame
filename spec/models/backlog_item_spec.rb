require 'spec_helper'

describe BacklogItem do
  fixtures :backlogs, :backlog_themes, :backlog_items
  
  it "should belongs to BacklogTheme" do
    item = backlog_items(:visualizar_perfil_do_arquiteto)
    item.backlog_theme.should == backlog_themes(:arquiteto)
  end

end
