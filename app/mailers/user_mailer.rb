class UserMailer < ApplicationMailer # This isn't being used at all
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Discovery App')
  end
end
