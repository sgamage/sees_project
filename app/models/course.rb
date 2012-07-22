class Course < ActiveRecord::Base
  attr_accessible :faculty_id, :name
  validates :name, :presence => true
  has_many :students
end
