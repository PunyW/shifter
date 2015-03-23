class WorkShift < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true
end
