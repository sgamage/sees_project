class RegistrationsController < Devise::RegistrationsController
  #user registration is not done via the UI, so simple redirect to login
  #before_filter :redirect_to_home
  
  #def redirect_to_home
  #  redirect_to root_path
  #end
  
  #protected

  #def after_sign_up_path_for(resource)
  #  'http://google.com'
  #end
  
end