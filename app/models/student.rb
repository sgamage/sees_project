class Student < ActiveRecord::Base
  HUMANIZED_ATTRIBUTES = {
    :uac_number => "UAC Number"
  }
  attr_accessible :address1, :address2, :completed, :confirm_email, 
                  :course_id, :date_of_birth, :declaration1, :declaration2, :declaration3, :acceptance, 
                  :email, :faculty_id, :first_name, :last_name, :mobile, :note1, :note2, :note3, 
                  :parent_mobile, :parent_name, :parent_phone, :phone, :post_code, :school_id, :state_id, 
                  :suburb, :title, :uac_number, :user_id
  
  attr_accessible :login_email, :password, :password_confirmation, :email_confirmation, :sec_school_accept, :validate_submit, :attached_files, :captcha_verified 
  attr_accessor :login_email, :password, :password_confirmation, :email_confirmation, :sec_school_accept, :validate_submit, :attached_files, :captcha_verified
                  
  belongs_to :user
  validates_associated :user   
  
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, :allow_blank => true
  validates :email_confirmation, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, :allow_blank => Proc.new { |a| a.email.blank?} 
  validates_confirmation_of :email
  validates :school, :presence => true
  validates :course, :presence => true
  
  validates :uac_number, :uniqueness => true, :numericality => true, :length => { :within => 1..9 }, :allow_blank => true
  validates :parent_phone, :length => { :within => 1..10 }, :allow_blank => true
  validates :parent_mobile, :length => { :within => 1..10 }, :allow_blank => true
  validates :mobile, :length => { :within => 1..10 }, :allow_blank => true
  validates :phone, :length => { :within => 1..10 }, :allow_blank => true
  validates :post_code, :length => { :within => 1..4 }, :allow_blank => true
  
  validates :note1, :presence => {:message => "Please fill the Co-curricular activities"}
  validates :note2, :presence => {:message => "Please fill academic achievements"}
  validates :note3, :presence => {:message => "Please fill the reason for study the selected course"}
  
  belongs_to :state
  belongs_to :school
  belongs_to :faculty
  belongs_to :course
  
               

  validate :new_user_login, :sec_school, :submittion, :validate_attachments, :application_acceptence, :accept_submit
  validate :captcha_error
  
  before_create :update_user
  
  has_many :student_files
  has_one :feedback
  has_one :student_status
  
  
  scope :submitted_applications, lambda {
    {:conditions => {:application_status_id => 1}}
  }
  
  scope :principal_reviewed_applications, lambda {
    {:conditions => {:application_status_id => 2}}
  }
  
  scope :for_my_school, lambda {|school_id|
    {:conditions => {:school_id => school_id}}
  }
  
  scope :for_course, lambda {|course_id|
    {:conditions => {:course_id => course_id}}
  }
  
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  def application_acceptence
    errors.add(:base, "You must accept Declaration") unless declaration1
    errors.add(:base, "You must accept Principal support for E12 application form") unless declaration2
  end
  
  def captcha_error
    if new_record?
     errors.add(:base, "Captcha verification failed") unless captcha_verified
    end 
  end
  
  def accept_submit
    errors.add(:base, "You must accept Submit confirmation") unless declaration3
  end  
  
  def principal_feedback_given?
    self.application_status_id == 2
  end
  
  def submittion
    if validate_submit == "1"
      unless vaidate_required_field?
        errors.add(:base, "Please fill all the required fields in order to submit the application")
      end  
    end
  end
  
  def new_user_login
    if self.new_record?
      u = User.new(:email => login_email, :password => password, :password_confirmation => password_confirmation)
      u.valid?
      u.errors.full_messages.each do |msg|
        errors.add(:base, msg)  
      end
    end
  end
  
  def sec_school
     if school.try(:category) && school.try(:category) != "EAS" 
       errors.add(:base, "Please confirm your willingness to submit a EAS application form") if sec_school_accept == "0"
     end
  end
  
  def update_user
    u = User.create(:email => login_email, :password => password, :password_confirmation => password_confirmation)
    self.user_id = u.id
  end
  
  def self.number_of_files
    3
  end
  
  def vaidate_required_field?
   !((title.blank?) || (first_name.blank?) || (last_name.blank?) || (date_of_birth.blank?) || (email.blank?) || (parent_name.blank?) || (suburb.blank?) || (uac_number.blank?) || (post_code.blank?))
  end
  
  def complete
    update_attribute("completed", true)
    status = ApplicationStatus.find_by_status("Application Received")
    update_attribute("application_status_id", status.id)
    StudentNotification.notification_email(self).deliver
    StudentNotification.principal_notification(self).deliver
    notify_first_time_principal
  end
  
  def notify_first_time_principal
    user = self.school.user
    #if user.sign_in_count == 0
      #user.sign_in_count == 0 means not yet login
      PrincipalNotification.notify_first_login(user).deliver  
    #end
  end
  
  def principal_feedback
    status = ApplicationStatus.find_by_status("Principal Application Received")
    update_attribute("application_status_id", status.id)
    StudentNotification.principal_feedback(self).deliver
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.logged_in_student(user_id)
    Student.find_by_user_id(user_id)
  end
  
  def feedback?
    #!self.feedback.nil?
    self.application_status_id == 1
  end
  
  def validate_attachments
    if attached_files
      attached_files.each do |f|
        file = f[1]
        errors.add(:base, "#{file.original_filename} is exceeding 2MB file size") if exceed_max_file_size?(file)
        errors.add(:base, "#{file.original_filename} is not a PDF file") unless validate_pdf(file.original_filename)
      end
    end
  end
  
  def uploaded_files
    student_files.length
  end
  
  def remaning_uploads
    Student.number_of_files - uploaded_files
  end
  
  def exceed_max_file_size?(file)
    file.size > 2000000 #2MB
  end
  
  def validate_pdf(file_name)
    file_name.split(".").last == "pdf"
  end
  
end
