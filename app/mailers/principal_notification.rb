class PrincipalNotification < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def notify_first_login(user)
    @user = user
    mail(:to => user.email, :subject => "Please activate your account")
  end
  
end