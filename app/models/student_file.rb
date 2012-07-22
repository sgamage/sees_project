class StudentFile < ActiveRecord::Base
  attr_accessible :name, :student_id
  belongs_to :student
end
