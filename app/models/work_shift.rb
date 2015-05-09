class WorkShift < ActiveRecord::Base
  has_many :shift_wishes
  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates_length_of :description, maximum: 200
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_length_of :short_name, maximum: 3, minimum: 1
end
