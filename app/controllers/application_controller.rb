class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def authorized?
    render file: "/public/404" unless current_user
  end
end
