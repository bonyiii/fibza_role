class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by_login("admin")
  end
end
