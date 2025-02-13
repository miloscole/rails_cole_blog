class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      notice custom: "Welcome to your account!"
      redirect_to user_path(user)
    else
      alert now: true
      render "new", status: 422
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
