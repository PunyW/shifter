class WorkShiftsController < ApplicationController
  before_action :signed_in?
  before_action :set_shift, only: [:show, :update]
  before_action :admin_only, only: [:update]

  def index
    @work_shifts = WorkShift.all
  end

  def show
  end

  def update
    if @work_shift.update_attributes(shift_params)
      head :no_content
    else
      render json: @work_shift.errors, status: :unprocessable_entity
    end
  end

  private
    def set_shift
      @work_shift = WorkShift.find(params[:id])
    end

    def shift_params
      params.require(:work_shift).permit(:name, :description, :duration, :start_time, :end_time)
    end
end