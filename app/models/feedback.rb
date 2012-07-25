class Feedback < ActiveRecord::Base
  attr_accessible :answers, :school_id, :student_id, :user_id, :support_student, 
  :application_support_status_id, :application_support_comment,
  :extra_note, :read_confirmation, :recommandation_level
  
  belongs_to :student
  has_many :feedback_question_answers
  has_one :application_support_status
  
  validates :application_support_comment, :length => { :within => 1..250 }, :allow_blank => true
  #validates :application_support_status, :presence => true
  validate :comment_when_other_option
  
  attr_accessible :feedback_validation 
  attr_accessor :feedback_validation
  
  after_update :set_question_answers
  
  #make sure principal enter a comment when the other option is selected
  def comment_when_other_option
    if ApplicationSupportStatus.find(application_support_status_id).try(:status) == "Other"
      if application_support_comment == ""
        errors.add(:base, "You must post a comment") 
        feedback_validation = 1 
      end  
    end
  end
  
  
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
