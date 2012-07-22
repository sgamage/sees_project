module FeedbacksHelper
  def category_list
    Category.all
  end
  
  def questions_for_category(category_id)
    Question.questions_for_category(category_id)
  end
  
  def answer_list
    Answer.all
  end
  
  def support_statues
    ApplicationSupportStatus.all
  end
  
end
