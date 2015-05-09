class ListsController < ApplicationController
  before_action :signed_in?
  before_action :admin_only

  def index
    @lists = List.all
  end

  def create
    @list = List.new(list_params)
    if @list.save
      render 'show', status: 201
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  private
    def list_params
      params.require(:list).permit(:id, :number, :length, :start_date, :end_date)
    end
end