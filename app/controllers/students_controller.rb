require 'fileutils'
class StudentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :submit, :show, :autocomplete_school_name]
  before_filter :cannot_create_application_for_already_created, :only => [:new, :create]
  before_filter :authorize_student, :only => [:show, :update, :edit]
  #autocomplete :school, :name
  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(@current_student_id)
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(@current_student_id)
    if @student.application_status_id 
      redirect_to student_path(@student)
    end     
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    #TODO: captcha removed for demo
    @student.captcha_verified = verify_recaptcha
    @student.validate_submit = params["final_submit_flag"] 
    @student.attached_files = params["file"]
    @attachments = Attachment.attachment_list(params["file"], params["file_name"])
    if @student.save
      Student.number_of_files.to_i.times do |i|
        unless params["file"].nil? || params["file"]["#{i}"].nil?
          tmp = params["file"]["#{i}"]#.tempfile
          file_name = params["file"]["#{i}"].original_filename
          directory_path = "public/data/#{@student.id}" 
          Dir.mkdir(directory_path) unless directory_exists?(directory_path)
          file_path = "public/data/#{@student.id}/#{file_name}"
          unless file_exist?(file_path)
            file = File.join("public/data/#{@student.id}", "#{file_name}")  
            display_name = params["file_name"]["#{i}"]
            StudentFile.create(:name => "#{file_name}", :student_id => @student.id, :display_name => display_name)
            FileUtils.cp tmp.path, file 
          end
        end  
      end
      message = "created"
      if @student.validate_submit == "1"
         message = "submitted"
         @student.complete if @student.vaidate_required_field?   
      end
      flash[:application_sucessful] = "Application successfully #{message}"
      if current_user
        redirect_to student_path(@student)
      else  
        redirect_to new_student_path
      end
        
    else
      @student.confirm_email = params[:student][:email_confirmation]
      render :action => "new" 
    end
  end

  def update
    @student = Student.find(@current_student_id)
    @student.validate_submit = params["final_submit_flag"]
    @student.attached_files = params["file"]
    if @student.update_attributes(params[:student])
      upload_count = @student.remaning_uploads
      upload_count.to_i.times do |i|
        unless params["file"].nil? || params["file"]["#{i}"].nil?
          tmp = params["file"]["#{i}"]#.tempfile
          file_name = params["file"]["#{i}"].original_filename
          directory_path = "public/data/#{@student.id}" 
          Dir.mkdir(directory_path) unless directory_exists?(directory_path)
          file_path = "public/data/#{@student.id}/#{file_name}"
          unless file_exist?(file_path)
            file = File.join("public/data/#{@student.id}", "#{file_name}")  
            display_name = params["file_name"]["#{i}"]
            StudentFile.create(:name => "#{file_name}", :student_id => @student.id, :display_name => display_name)
            FileUtils.cp tmp.path, file
          end
          
        end  
      end
      message = "saved"
      if @student.validate_submit == "1"
         message = "submitted"
         @student.complete if @student.vaidate_required_field?   
      end
      flash[:application_sucessful] = "Application successfully #{message}"
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
  
  def authorize_student
    @current_student_id = (current_user.student?) ? current_user.student_id : params[:id]
  end
  
  private
  def directory_exists?(directory)
    File.directory?(directory)
  end
  
  def file_exist?(file_path)
    File.exist?(file_path)
  end  
  
end
