class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_status

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

    def self.authorize_action(actions, roles)
      roles = roles.map { |r| r.to_sym }

      append_before_filter(only: actions) do
        unless current_user && roles.include?(current_user.role.to_sym)
          request_http_basic_authentication
        end
      end
    end

    def role_scope(relation, param, chain = nil)
      chain ||= current_user if current_user.user?
      scope = chained_scope(relation, chain).find(param)

      scope ? scope : request_http_basic_authentication
    end

    def chained_scope(relation, chain = nil)
      chain ? chain.send(relation) : relation.to_s.classify.constantize
    end

    def not_found_status
      head(:not_found)
    end

end
