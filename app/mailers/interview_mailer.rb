class InterviewMailer < ActionMailer::Base
  def interview_email(interview)
	  @interview = interview
	  @employer_id = Employer.find(@interview.employer_id)
	  @interview_email = User.find(@employer_id.user_id).email
    mail(to: @interview_email,
         from: "FreelanceHub",
         subject: "Someone applied to your job"
     	  )
  end
end