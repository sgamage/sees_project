module DeviseHelper
  def devise_error_messages!
    errors = []
    resource.errors.full_messages.each do |msg|
      if msg == "Email can't be blank"
        msg = "Please enter a valid email"
      end
      errors << msg
    end
    errors
  end

  def devise_error_messages2!
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
  end
end