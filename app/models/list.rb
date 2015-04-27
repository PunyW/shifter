class List < ActiveRecord::Base
  validates_presence_of(:length, :number, :start_date, :end_date)
end
