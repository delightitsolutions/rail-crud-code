class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show destroy update]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :req_same_user, only: [:edit, :update, :destroy]
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the alpha blog #{@user.username},you have successfully signed up!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @articles = @user.articles.paginate(page: params[:page])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:alert] = 'Account and all associated articles are successfully deleted'
    session[:user_id] = nil
    redirect_to articles_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def req_same_user
    if current_user != @user
      flash[:alert] = 'You can only edit your own profile'
      redirect_to @user
    end
  end
end