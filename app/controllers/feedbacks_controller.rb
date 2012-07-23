class FeedbacksController < ApplicationController
  before_filter :authenticate_user!, :except => [:update]
  protect_from_forgery :except => [:update]
  def new
    @feedback = Feedback.new
    @student = Student.find(params[:id])
  end

  def create
    @feedback = Feedback.new(params[:feedback])
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
      @student = @feedback.student
      render action: "new"
    end 
  end
  
  def edit
    @feedback = Feedback.find(params[:id])
    @student = @feedback.student
    @school = @student.school
  end
  
  def update
    @feedback = Feedback.find(params[:id])
    student = @feedback.student
    @feedback.update_attributes(:extra_note => params[:extra_note], :read_confirmation => params[:confirm], :answers => params[:answers])
    student.principal_feedback
    render :json => @feedback, :status => :created, :location => @feedback
  end
  
end
