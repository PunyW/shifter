class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng


  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all { render nothing: true, status: 404 }
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
    helper_method :current_user
    helper_method :signed_in?
    helper_method :admin_only

    def current_user
      @current_user ||= User.find_by(username: request.headers['username'])
    end

    def signed_in?
      @user = current_user
      if @user && @user.token = request.headers['token']
        true
      else
        render nothing: true, status: 401
      end
    end

    def admin_only
      if signed_in? && current_user.admin?
        true
      else
        render nothing: true, status: 401
      end
    end

    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end
end
