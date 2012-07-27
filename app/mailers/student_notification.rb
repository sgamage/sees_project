class StudentNotification < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def notification_email(student)
    @student = student
    email_attachments = StudentFile.find_all_by_student_id(@student.id)
    email_attachments.each do |file|
      attachments[file.name.to_s] = File.read("#{Rails.root}/public/data/#{@student.id}/#{file.name}")
    end
    mail(:to => student.email, :subject => "Thank-you for submitting an E12 application")
  end
  
  def principal_notification(student)
    @student = student
    @school = student.school
    principal = @school.user 
    @path = "http://alliontechnologies.railsplayground.net/"
    mail(:to => principal.email, :subject => "A Student submitted an E12 application") 
  end
  
  def principal_feedback(student)
    @student = student
    @school = student.school
    principal = @school.user
    mail(:to => principal.email, :subject => "Principal feedback given") 
  end
  
end

  