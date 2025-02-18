class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @confirmation_url = confirm_user_url(user.generate_token_for(:email_confirmation))

    mail(to: user.email, subject: "Please, confirm your email.")
  end
end
