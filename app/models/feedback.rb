class Feedback < ActiveRecord::Base
  attr_accessible :answers, :school_id, :student_id, :user_id, :support_student, 
  :application_support_status_id, :application_support_comment,
  :extra_note, :read_confirmation, :recommandation_level
  
  belongs_to :student
  has_many :feedback_question_answers
  
  validates :application_support_comment, :length => { :within => 1..250 }, :allow_blank => true
  
  after_update :set_question_answers
  
  def set_question_answers
    #10-6,11-2,12-1
    answers_arr = answers.split(",")
    answers_arr.each do |answer|
      vals = answer.to_s.split("-")
      question = vals[0]
      ans = vals[1]
      FeedbackQuestionAnswer.create(:feedback_id => id, :question_id => question, :answer_id => ans)
    end 
  end

end
