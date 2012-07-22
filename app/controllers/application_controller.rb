class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  #def after_sign_in_path_for(resource)
  #  #redirect_to "http://google.com"
  #end
  
end
