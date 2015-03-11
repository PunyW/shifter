class UsersController < ApplicationController
  before_action :signed_in?, only: [:edit]

  def update
    if current_user.update(user_params)
      render json: current_user, status: 200
    else
      render nothing: true, status: 422
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end