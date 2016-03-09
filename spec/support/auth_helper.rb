module AuthHelper
  def http_auth(username, password)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username,password)
  end
end
