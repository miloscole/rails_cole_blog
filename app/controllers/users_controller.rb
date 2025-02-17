class UsersController < ApplicationController
  before_action :require_logged_in_user, only: [ :edit, :update, :destroy ]
  before_action :set_user, only: [ :edit, :update, :show, :destroy ]
  before_action :require_account_owner, only: [ :edit, :update ]

  def index
    @users = User.with_articles_and_pagination(params[:page], 4)
  end


  def show
    @user_articles = @user.articles_with_pagination(params[:page], 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      notice custom: "#{@user.username} welcome to the #{APP_NAME}!"
      redirect_to user_path(@user)
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      notice
      redirect_to user_path(@user)
    else
      render "edit", status: 422
    end
  end

  def destroy
    permissions_for_destroy
    @user.destroy
    notice
    redirect_to users_path
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_account_owner
    unless current_user == @user
      alert custom_msg: "You can perform this action only on your own account!"
      redirect_to root_path
    end
  end

  def permissions_for_destroy
    return if current_user == @user

    unless current_user.admin?
      alert custom_msg: "This action is allowed only for admin!"
      redirect_to root_path
      return
    end

    if @user.admin? && current_user != @user
      alert custom_msg: "Admins cannot delete other admins!"
      redirect_to root_path
    end
  end
end
