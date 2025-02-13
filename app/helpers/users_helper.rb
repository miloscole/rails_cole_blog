module UsersHelper
  def show_delete_button?(user)
    return true if current_user == user
    return false if user.admin?
    current_user&.admin?
  end
end
