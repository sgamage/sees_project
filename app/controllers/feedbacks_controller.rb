class FeedbacksController < ApplicationController
  before_filter :authenticate_user!, :except => [:update]
  before_filter :handle_principal
  before_filter :handle_student_login
  protect_from_forgery :except => [:update]
  
  def new
    @feedback = Feedback.new
    @student = Student.find(params[:id])
    authorize_feedback_new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    authorize_feedback
    if @feedback.save
       if params[:feedback][:support_student] == "0"
         student = @feedback.student
         student.principal_feedback
         flash[:application_sucessful] = "Feedback successfully submitted"
         redirect_to root_path  
       else
         redirect_to edit_feedback_path(@feedback)
       end
       
    else
      @feedback.feedback_validation = 1
      @student = @feedback.student
      render action: "new"
    end 
  end
  
  def edit
    @feedback = Feedback.find(params[:id])
    authorize_feedback
    @student = @feedback.student
    @school = @student.school
  end
  
  def update
    @feedback = Feedback.find(params[:id])
    authorize_feedback
    student = @feedback.student
    @feedback.update_attributes(:extra_note => params[:extra_note], :read_confirmation => params[:confirm], :answers => params[:answers])
    student.principal_feedback
    render :json => @feedback, :status => :created, :location => @feedback
  end
  
  def authorize_feedback
    if current_user && !current_user.admin?
      redirect_to root_path unless (@feedback.school_id == session[:school].try(:id)) 
    end
  end
  
  def authorize_feedback_new
    if current_user && !current_user.admin?
      redirect_to root_path unless (@student.school_id == session[:school].try(:id)) 
    end
  end
  
end
