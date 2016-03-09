class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authenticate
      user = authenticate_user
      user ? @current_user = user : request_http_basic_authentication
    end

    def authenticate_user
      authenticate_with_http_basic do |username, password|
        user = User.find_by_username(username)
        user && user.authenticate(password)
      end
    end
end
