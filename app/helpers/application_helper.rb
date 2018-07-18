module ApplicationHelper
  def card_fields_class
    "hidden" if current_user.card_last4?
  end
  
  def full_date date
    date.to_date.strftime("%B %d, %Y") rescue ''
  end 
  
  def month_date date
    date.to_date.strftime("%B, %Y") rescue ''
  end 
  
  def is_job_applied job_id, student
    student.applied_jobs.find(job_id).present? rescue false
  end  
  
  def current_action(controller)
    case controller
      when "users"
       "Dashboard"
      when "interviews"
        current_user && current_user.is_employer? ? "Student Applications" : "My Proposals"
      when "subscriptions"  
        "Billing"
      when "employer_profiles"
        "Company Profile"
      when "employer_wizards"
        "New Job"
      when "conversations"
         "Conversations"
      when "students"
         "Student Ad"
       when "employer_profiles"
         "Resume"
      else
       ""
    end
  end  
  
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end
  
  def student_ad_picture student
    if student.student_ad_pictures.empty?
      "https://www.kirkleescollege.ac.uk/wp-content/uploads/2015/09/default-avatar.png"
    else
      student.student_ad_pictures.first.url(:original)
    end
  end
  
  def student_profile_picture student
    if student.user.student_profile.nil? || student.user.student_profile.avatars.empty?
      "https://www.kirkleescollege.ac.uk/wp-content/uploads/2015/09/default-avatar.png"
    else
      student.user.student_profile.avatars.first.url(:small)
    end
    rescue
     "https://www.kirkleescollege.ac.uk/wp-content/uploads/2015/09/default-avatar.png"
  end
end