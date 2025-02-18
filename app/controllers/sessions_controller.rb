class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      handle_confirmed_user(user)
    else
      alert now: true
      render "new", status: 422
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def handle_confirmed_user(user)
    if user.confirmed?
      session[:user_id] = user.id
      notice custom: "Welcome to your account!"
      redirect_to user_path(user)
    else
      alert now: true, custom: "Your account is not confirmed!"
      render "new", status: 422
    end
  end
end
