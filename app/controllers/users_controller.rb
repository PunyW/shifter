class UsersController < ApplicationController
  before_action :signed_in?, except: [:create]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show', status: 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_params)
      render json: current_user, status: 200
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end