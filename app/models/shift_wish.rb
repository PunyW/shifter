class ShiftWish < ActiveRecord::Base
  belongs_to :employee
  belongs_to :work_shift
end
