class WorkShiftsController < ApplicationController
  before_action :signed_in?
  
  def index
    @work_shifts = WorkShift.all
  end
end