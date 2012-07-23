module ApplicationHelper
  def format_date date
    date.strftime('%d-%m-%Y')
  end
  
  def empty_string? str
     str == ""
  end
  
  def school_name_display
    "FOR #{session[:school].try(:name)}" if session[:school]
  end
  
end
