class StudentNotification < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def notification_email(student)
    @student = student
    mail(:to => student.email, :subject => "Thank-you for submitting an E12 application")
    
  end
  
end

  