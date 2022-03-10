class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in succesfully"
      redirect_to user
    else
      flash.now[:danger] = "Email or password are incorrect"
      render 'new', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:warning] = "Logged out"
    redirect_to root_path
  end
end