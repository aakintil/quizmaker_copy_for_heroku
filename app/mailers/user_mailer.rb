class UserMailer < ActionMailer::Base
  default from: "quizmaker.team@gmail.com"

  def welcome_email(user)
    @user = user
    @support_email = "quizmaker.team@gmail.com"
    mail to: @user.email, subject: "Welcome to QuizMaster!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "QuizMaster Password Reset"
  end
end
