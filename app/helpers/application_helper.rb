module ApplicationHelper
  def format_date date
    date.strftime('%d-%m-%Y')
  end
  
  def empty_string? str
     str == ""
  end
  
end
