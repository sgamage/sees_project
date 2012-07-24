class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type
  # attr_accessible :title, :body
  
  has_many :users
  
  def student?
    user_type == "STUDENT"
  end
  
  def principal?
    user_type == "PRINCIPAL"
  end
  
  def admin?
    user_type == "ADMIN"
  end
  
  def student_id
    Student.find_by_user_id(self.id).try(:id) if student? 
  end
  
  
end
