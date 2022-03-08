# Users controller that handles all actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to the ALpha blog. You've been succesfully signed up!"
      redirect_to articles_path
    else
      render 'new', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Your account information was succesfully updated'
      redirect_to articles_path
    else
      render 'edit', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  private

  def set_user
    @user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end