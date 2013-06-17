class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def require_login
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "admin"
    end
  end
end
