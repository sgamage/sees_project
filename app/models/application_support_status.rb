class ApplicationSupportStatus < ActiveRecord::Base
  attr_accessible :status
  belongs_to :feedback
end
