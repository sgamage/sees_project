class Course < ActiveRecord::Base
  attr_accessible :faculty_id, :name, :faculty_name, :course_code
  
  attr_accessible :display_course_name
  attr_accessor :display_course_name
  
  validates :name, :presence => true
  has_many :students
  
  def display_course_name
    "#{name} - #{course_code} - #{faculty_name}"
  end
  
end
