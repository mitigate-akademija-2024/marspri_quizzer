class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    Rails.logger.debug "User before save: #{@user.attributes.except('password', 'password_confirmation').inspect}"
    if @user.save
      Rails.logger.debug "User after save: #{@user.reload.attributes.except('password', 'password_confirmation').inspect}"
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully registered!"
    else
      Rails.logger.debug "User creation failed: #{@user.errors.full_messages}"
      Rails.logger.debug "User attributes: #{@user.attributes.except('password', 'password_confirmation').inspect}"
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
end
