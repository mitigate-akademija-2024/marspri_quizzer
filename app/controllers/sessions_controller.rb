class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by("lower(email) = ?", params[:login].downcase) || 
           User.find_by("lower(username) = ?", params[:login].downcase)
    
    Rails.logger.debug "Login attempt with: #{params[:login]}"
    Rails.logger.debug "User found: #{user.inspect}"
    
    if user && user.authenticate(params[:password])
      Rails.logger.debug "Authentication successful"
      session[:user_id] = user.id
      redirect_to params[:redirect_to] || root_path, notice: "Logged in successfully!"
    else
      Rails.logger.debug "Authentication failed"
      flash.now[:alert] = "Invalid username/email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
