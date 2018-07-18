class UserMailer < ActionMailer::Base
  def welcome_student_email(user)
	  @user = user
	  mail(to: @user.email, from: "FreelanceHub <noreply@freelancehub.com>", subject: "Welcome To FreelanceHub")
  end

  def welcome_employer_email(user)
    @user = user
    mail(to: @user.email, from: "FreelanceHub <noreply@freelancehub.com>", subject: "Welcome To FreelanceHub")
  end

  def congrats_email(user)
    @user = user
    mail(to: @user.email, from: "FreelanceHub <noreply@freelancehub.com>", subject: "Congratulations")
  end
end