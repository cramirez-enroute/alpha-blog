# Users controller that handles all actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

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
    @user
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account information was successfully updated'
      redirect_to user_path
    else
      render 'edit', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end