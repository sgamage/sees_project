class Question < ActiveRecord::Base
  attr_accessible :category_id, :question_text
  
  belongs_to :category
  has_many :feedback_question_answers
  
  scope :study_skills, lambda {
    {:conditions => {:category_id => 1}}
  }
  
  scope :questions_for_category, lambda {|category_id|
    {:conditions => {:category_id => category_id}}
  }
  
end
