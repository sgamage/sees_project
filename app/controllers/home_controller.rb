class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:login]
  before_filter :handle_student_login, :except => [:login]
  
  before_filter :handle_principal
  
  def index
    school_id = course_id = applicationstatus_id = 0
    student_name = ""
    @students = []
    if current_user.principal?
      if session[:school]
        @students = Student.submitted_applications.for_my_school(session[:school].id).order(:application_status_id)
      end
    elsif current_user.admin?
      school_id = params[:schools].first if params[:schools] 
      course_id = params[:course].first if params[:course]
      applicationstatus_id = params[:applicationstatus].first if params[:course]
      student_name = params[:student_name]
      @students = Student.all
      if school_id.to_i != 0
        @students = Student.for_my_school(school_id)  
      end
    end
  end
  
  def login
    redirect_to new_user_session_path
  end
  
  
end
