class ApplicationController < ActionController::Base
  include Flashable
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in_user
    unless logged_in?
      alert custom_msg: "You must be signed in to perform that action!"
      redirect_to root_path
    end
  end
end
