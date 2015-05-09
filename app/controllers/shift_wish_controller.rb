class ShiftWishController < ApplicationController
  before_action :signed_in?
  before_action :set_shift_wish, only: [:update]

  def index
    @shift_wishes = ShiftWish.all
  end

  def create
    @shift_wish = ShiftWish.new(shift_wish_params)
    if @shift_wish.save
      render 'show', status: 201
    else
      render json: @shift_wish.errors, status: :unprocessable_entity
    end
  end

  def update
    if @shift_wish.update_attributes(shift_wish_params)
      head :no_content
    else
      render json: @shift_wish.errors, status: :unprocessable_entity
    end
  end

  private
    def set_shift_wish
      @shift_wish = ShiftWish.find(params[:id])
    end

    def shift_wish_params
      params.require(:shift_wish).permit(:employee_id, :date_number, :month_number, :work_shift_id)
    end
end