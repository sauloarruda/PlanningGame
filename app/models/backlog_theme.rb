# represents a theme of stories in backlog
class BacklogTheme < ActiveRecord::Base
  belongs_to :backlog
end
