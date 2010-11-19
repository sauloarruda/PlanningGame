require 'spec_helper'

describe Backlog do
  fixtures :backlogs
  it "should find by id" do
    backlog = Backlog.find_by_id(backlogs(:rede_social_arquitetos))
    backlog.name.should == 'Rede Social de Arquitetos'
  end
end
