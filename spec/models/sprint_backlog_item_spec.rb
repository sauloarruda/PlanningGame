require 'spec_helper'

describe SprintBacklogItem do
  fixtures :backlogs, :backlog_themes, :backlog_items, :projects, :sprints, :sprint_backlog_items
  
  it "should belongs to backlog_item and sprint" do
    item = sprint_backlog_items(:jera_rsa_1_visualizar_perfil_da_empresa)
    item.backlog_item.should eql(backlog_items(:visualizar_perfil_da_empresa))
    item.sprint.should eql(sprints(:jera_rsa_1))
  end

  it "should return backlog_items from project" do
    pending "add sprint_id on expectation"
    items = SprintBacklogItem.all(projects(:alfa_rsa))
    items.should have(12).records
    items.to_json.should eql('[{"done":true,"id":738001566,"backlog_item_id":510360074},{"done":true,"id":897253599,"backlog_item_id":470307930},{"done":true,"id":463923796,"backlog_item_id":542149447},{"done":true,"id":435879345,"backlog_item_id":731456063},{"done":true,"id":250746411,"backlog_item_id":787296314},{"done":true,"id":746462366,"backlog_item_id":567492963},{"done":true,"id":33362239,"backlog_item_id":61873896},{"done":true,"id":29873461,"backlog_item_id":542149447},{"done":true,"id":868688057,"backlog_item_id":947906800},{"done":true,"id":380856021,"backlog_item_id":209392792},{"done":true,"id":551392750,"backlog_item_id":699408949},{"done":false,"id":692491138,"backlog_item_id":916701017}]')
  end
  
end
