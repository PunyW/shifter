class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: @user, status: 200, serializer: UserSerializer
    else
      render json: { error: 'Email/password combination invalid' }, status: 401
    end
  end
end