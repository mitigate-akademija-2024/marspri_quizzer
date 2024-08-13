class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access this page."
      redirect_to login_path(redirect_to: request.original_url)
    end
  end
end
