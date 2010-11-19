class Project < ActiveRecord::Base
  belongs_to :team

  def start_date
    self.created_at
  end

end
