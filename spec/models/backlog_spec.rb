require 'spec_helper'

describe Backlog do
  fixtures :backlogs
  before(:each) do
    @backlog = Backlog.find_by_id(backlogs(:rede_social_arquitetos))
  end

  it "should find by id" do
    @backlog.name.should == 'Rede Social de Arquitetos'
  end
end
