class FeedbackQuestionAnswer < ActiveRecord::Base
  attr_accessible :answer_id, :feedback_id, :question_id
  belongs_to :feedback
  belongs_to :questions
  belongs_to :answers
  
  scope :selected_answer, lambda { |feedback_id, question_id|
    {:conditions => {:feedback_id => feedback_id, :question_id => question_id}}
  }
  
  
  def self.show_selected_answer(feedback_id, question_id)
    ans = ""
    answers = selected_answer(feedback_id, question_id)
    answers
    if !answers.empty?
      answer_id = answers.first.answer_id
      answer = Answer.find(answer_id)
      ans = answer.answer_text
    end
    ans
  end
  
  
end
