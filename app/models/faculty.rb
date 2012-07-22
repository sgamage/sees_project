class Faculty < ActiveRecord::Base
  attr_accessible :name, :school_id
  validates :name, :presence => true
  has_many :students
end
