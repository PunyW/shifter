class WorkShift < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
