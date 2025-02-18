class ApplicationController < ActionController::Base
  include Flashable
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in_user
    unless logged_in?
      alert custom: "You must be signed in to perform that action!"
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user&.admin?
      alert custom: "That action is allowed only for admin user"
      redirect_to root_path
    end
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false
  end
end
