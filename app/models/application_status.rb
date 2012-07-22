class ApplicationStatus < ActiveRecord::Base
  attr_accessible :status
  
  belongs_to :student
end
