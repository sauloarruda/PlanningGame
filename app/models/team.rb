# represents a team that can develop many projects
class Team < ActiveRecord::Base
  default_scope :order => "name"
end
