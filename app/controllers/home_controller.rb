class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:login]
  before_filter :handle_student_login, :except => [:login]
  
  before_filter :handle_principal
  
  def index
    @students = nil
    if current_user.principal?
      if session[:school]
        @students = Student.submitted_applications.for_my_school(session[:school].id).order(:application_status_id)
      else
        @students = []  
      end
       
    elsif current_user.admin?
      @students = Student.all 
    end
  end
  
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
  
  def login
    redirect_to new_user_session_path
  end
  
  
end
