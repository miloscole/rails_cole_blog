module ArticlesHelper
  def show_action_buttons?(article)
    logged_in? && (current_user == article.user || current_user.admin?)
  end
end
