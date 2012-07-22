class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:login]
  before_filter :handle_student_login, :except => [:login]
  
  def index
    @students = Student.submitted_applications
  end
  
  def handle_student_login
    if current_user.student?
      student = Student.logged_in_student(current_user.id)
      if student.vaidate_required_field?
        #redirect_to edit_student_path(student)
        redirect_to student_path(student)
      else
        #redirect_to student_path(student)
        redirect_to edit_student_path(student)  
      end
    end
  end
  
  def login
    redirect_to new_user_session_path
  end
  
  
end
