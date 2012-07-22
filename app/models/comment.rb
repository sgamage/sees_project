class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :student_id
  
   belongs_to :student
  
end
