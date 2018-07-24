class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if current_user.admin?
        redirect_to admin_dashboard_index_path
      else
        redirect_to dashboard_path
      end
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
