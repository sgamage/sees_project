module ApplicationHelper
  def format_date date
    date.strftime('%m-%d-%Y')
  end
  
  def empty_string? str
     str == ""
  end
  
end
