class Employee < ActiveRecord::Base
  belongs_to :user

  before_save :format_percentage

  validates :work_percent, numericality: { greater_than_or_equal_to: 0,
                                           less_than_or_equal_to: 100 }
  validates :first_name, presence: true, allow_nil: false
  validates :last_name, presence: true, allow_nil: false

  def format_percentage
    self.work_percent = self.work_percent / 100
  end
end
