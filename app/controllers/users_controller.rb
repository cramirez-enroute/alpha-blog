# Users controller that handles all actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[show index edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha blog. You've been succesfully signed up!"
      redirect_to articles_path
    else
      render 'new', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: ARTICLES_PAGINATION_LIMIT).order('id DESC')
  end

  def index
    @users = User.paginate(page: params[:page], per_page: USERS_PAGINATION_LIMIT).order('id DESC')
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account information was successfully updated'
      redirect_to user_path
    else
      render 'edit', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:warning] = "Account and all associated articles has been succesfully deleted"
    redirect_to articles_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:warning] = 'You can only edit or delete your own account!'
      redirect_to user_path(@user)
    end
  end
end
