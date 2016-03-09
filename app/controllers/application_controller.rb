class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user
  end

  protected

    def authenticate
      user = authenticate_user
      if user
        @current_user = user
      else
        request_http_basic_authentication
      end
    end

    def authenticate_user
      authenticate_with_http_basic do |username, password|
        user = User.find_by_username(username)
        user && user.authenticate(password)
      end
    end
end
