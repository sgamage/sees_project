class Answer < ActiveRecord::Base
  attr_accessible :answer_text
  has_many :feedback_question_answers
end
