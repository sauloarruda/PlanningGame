# represents a product backlog
class Backlog < ActiveRecord::Base
  default_scope :order => "name"
end