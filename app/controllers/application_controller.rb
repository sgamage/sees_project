class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  def handle_student_login
    if current_user.student?
      student = Student.logged_in_student(current_user.id)
      
      if student
        redirect_to edit_student_path(student)
      end
    end
  end
  
  def handle_principal
    if current_user.principal?
      school = School.find_by_user_id(current_user.id)
      session[:school] = school
    end
  end
  
end
