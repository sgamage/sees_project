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
       redirect_to edit_feedback_path(@feedback)
    else
      render action: "new"
      @student = Student.find(@student.id)
    end 
  end
  
  def edit
    @feedback = Feedback.find(params[:id])
  end
  
  def update
    @feedback = Feedback.find(params[:id])
    student = @feedback.student
    @feedback.update_attributes(:extra_note => params[:extra_note], :read_confirmation => params[:confirm], :answers => params[:answers])
    student.principal_feedback
    render :json => @feedback, :status => :created, :location => @feedback
  end
  
end
