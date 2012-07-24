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
  
  def get_state
    # Need to do this as we need to keep the flexibility of adding
    # new states later
    State.find_by_name('NSW')
  end
  
end
