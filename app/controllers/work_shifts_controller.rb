class WorkShiftsController < ApplicationController
  before_action :signed_in?
  before_action :set_shift, only: [:show, :update, :destroy]
  before_action :admin_only, only: [:update, :destroy]

  def index
    @work_shifts = WorkShift.all
  end

  def show
  end

  def create
    @work_shift = WorkShift.create(shift_params)
    if @work_shift.save
      render 'show', status: 201
    else
      render json: @work_shift.errors, status: :unprocessable_entity
    end
  end

  def update
    if @work_shift.update_attributes(shift_params)
      head :no_content
    else
      render json: @work_shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @work_shift.destroy
    head :no_content
  end

  private
    def set_shift
      @work_shift = WorkShift.find(params[:id])
    end

    def shift_params
      params.require(:work_shift).permit(:name, :description, :duration, :start_time, :end_time, :short_name)
    end
end