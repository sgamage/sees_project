class HomeController < ApplicationController
  before_filter :handle_student_login
  
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
  
end
