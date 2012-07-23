require 'fileutils'
class StudentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :submit, :show, :autocomplete_school_name]
  before_filter :cannot_create_application_for_already_created, :only => [:new, :create]
  #autocomplete :school, :name
  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    #TODO: captcha removed for demo
    if verify_recaptcha
      @student.validate_submit = params["final_submit_flag"] 
      @student.attached_files = params["file"]
      #debugger
      if @student.save
        Student.number_of_files.to_i.times do |i|
          unless params["file"].nil? || params["file"]["#{i}"].nil?
            tmp = params["file"]["#{i}"]#.tempfile
            file_name = params["file"]["#{i}"].original_filename
            file = File.join("public/data", "#{@student.id}#{file_name}")
            display_name = params["file_name"]["#{i}"]
            StudentFile.create(:name => "#{@student.id}#{file_name}", :student_id => @student.id, :display_name => display_name)
            FileUtils.cp tmp.path, file
          end  
        end
        if @student.validate_submit == "1"
           @student.complete if @student.vaidate_required_field?   
        end
        flash[:application_sucessful] = 'Application successfully created'
        redirect_to student_path(@student)  
      else
        @student.confirm_email = params[:student][:email_confirmation]
        render :action => "new" 
      end
    else
      @student.errors.add(:base, "Captcha verification failed")
      render :action => "new" 
    end  
  end

  def update
    @student = Student.find(params[:id])
    @student.validate_submit = params["final_submit_flag"]
    @student.attached_files = params["file"]
    if @student.update_attributes(params[:student])
      upload_count = @student.remaning_uploads
      upload_count.to_i.times do |i|
        unless params["file"].nil? || params["file"]["#{i}"].nil?
          tmp = params["file"]["#{i}"]#.tempfile
          file_name = params["file"]["#{i}"].original_filename
          file = File.join("public/data", "#{@student.id}#{file_name}")
          display_name = params["file_name"]["#{i}"]
          StudentFile.create(:name => "#{@student.id}#{file_name}", :student_id => @student.id, :display_name => display_name)
          FileUtils.cp tmp.path, file
        end  
      end
      if @student.validate_submit == "1"
         @student.complete if @student.vaidate_required_field?   
      end
      flash[:application_sucessful] = 'Application successfully submitted'
      redirect_to student_path(@student)   
    else
      render :action => "edit"
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end
  
  def submit
    
  end
  
  def cannot_create_application_for_already_created
    #FIXME: do not allow the new action for already logged users 
  end
  
end
