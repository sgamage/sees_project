class Student < ActiveRecord::Base
  attr_accessible :address1, :address2, :completed, :confirm_email, 
                  :course_id, :date_of_birth, :declaration1, :acceptance, 
                  :email, :faculty_id, :first_name, :last_name, :mobile, :note1, :note2, :note3, 
                  :parent_mobile, :parent_name, :parent_phone, :phone, :post_code, :school_id, :state_id, 
                  :suburb, :title, :uac_number, :user_id
  
  attr_accessible :login_email, :password, :password_confirmation, :email_confirmation, :sec_school_accept, :validate_submit
  attr_accessor :login_email, :password, :password_confirmation, :email_confirmation, :sec_school_accept, :validate_submit
                  
  belongs_to :user
  validates_associated :user   
  
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, :allow_blank => true
  validates :email_confirmation, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, :allow_blank => Proc.new { |a| a.email.blank?} 
  validates_confirmation_of :email
  validates :school, :presence => true
  validates :uac_number, :uniqueness => true
  
  validates :parent_phone, :length => { :within => 1..10 }, :allow_blank => true
  validates :parent_mobile, :length => { :within => 1..10 }, :allow_blank => true
  validates :mobile, :length => { :within => 1..10 }, :allow_blank => true
  validates :phone, :length => { :within => 1..10 }, :allow_blank => true
  validates :post_code, :length => { :within => 1..4 }, :allow_blank => true
  
  validates :note1, :length => { :within => 1..250 }, :allow_blank => true
  validates :note2, :length => { :within => 1..250 }, :allow_blank => true
  validates :note3, :length => { :within => 1..250 }, :allow_blank => true
  
  
  belongs_to :state
  belongs_to :school
  belongs_to :faculty
  belongs_to :course
  
               

  validate :new_user_login, :sec_school, :submittion
  
  before_create :update_user
  
  has_many :student_files
  has_one :feedback
  has_one :student_status
  
  scope :submitted_applications, lambda {
    {:conditions => {:completed => true}}
  }
  
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
       errors.add(:base, "Please confirm your willingess to submit a EAS application form") if sec_school_accept == "0"
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
   !((title.blank?) || (first_name.blank?) || (last_name.blank?) || (date_of_birth.blank?) || (email.blank?) || (parent_name.blank?) || (suburb.blank?) || (uac_number.blank?))
  end
  
  def complete
    update_attribute("completed", true)
    status = ApplicationStatus.find_by_status("Application Received")
    update_attribute("application_status_id", status.id)
    StudentNotification.notification_email(self).deliver
  end
  
  def full_name
    "#{last_name} #{first_name}"
  end
  
  def self.logged_in_student(user_id)
    Student.find_by_user_id(user_id)
  end
  
  def feedback?
    !self.feedback.nil?
  end
  
end
