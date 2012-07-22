class StudentFile < ActiveRecord::Base
  attr_accessible :name, :student_id, :display_name
  belongs_to :student
end
