require 'spec_helper'

describe BacklogTheme do
  fixtures :backlogs, :backlog_themes
  
  it "should belongs to backlog" do
    theme = BacklogTheme.find_by_id backlog_themes(:arquiteto)
    theme.backlog.should == backlogs(:rede_social_arquitetos)
  end
end
