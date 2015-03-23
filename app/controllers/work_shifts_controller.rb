class WorkShiftsController < ApplicationController
  before_action :signed_in?
  before_action :set_shift, only: [:show]

  def index
    @work_shifts = WorkShift.all
  end

  def show
  end

  private
    def set_shift
      @work_shift = WorkShift.find(params[:id])
    end

    def shift_params
      params.require(:work_shift).permit(:name, :description, :duration, :start_time, :end_time)
    end
end