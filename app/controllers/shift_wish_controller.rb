class ShiftWishController < ApplicationController
  before_action :signed_in?

  def index
    @shift_wishes = ShiftWish.all
  end

  def create
    shift_wish = ShiftWish.find_by_employee_id_and_date_number_and_month_number(
      params[:employee_id], params[:date_number], params[:month_number])
    if shift_wish
      update(shift_wish)
    end

    @shift_wish = ShiftWish.new(shift_wish_params)
    if @shift_wish.save
      render 'show', status: 201
    else
      render json: @shift_wish.errors, status: :unprocessable_entity
    end
  end

  def update(shift_wish)
    @shift_wish = shift_wish
    if @shift_wish.update_attributes(shift_wish_params)
      head :no_content
    else
      render json: @shift_wish.errors, status: :unprocessable_entity
    end
  end

  def show
    @shift_wish = ShiftWish.find_by_employee_id_and_date_number_and_month_number(
      params[:employee_id], params[:date_number], params[:month_number])
    if @shift_wish
      render 'show', status: 200
    end
  end

  private
    def shift_wish_params
      params.require(:shift_wish).permit(:employee_id, :date_number, :month_number, :work_shift_id)
    end
end