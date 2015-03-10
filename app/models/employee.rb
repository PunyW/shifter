class Employee < ActiveRecord::Base
  before_save :format_percentage

  def format_percentage
    self.work_percent = self.work_percent / 100
  end
end
