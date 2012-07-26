class School < ActiveRecord::Base
  attr_accessible :name, :email, :category, :user_id
  validates :name, :presence => true
  has_many :students
  belongs_to :user #principal
  
  def display_title
    "#{name} (#{category})"
  end
  
  def principal_name
    "#{principal_title} #{principal_firstname} #{principal_surname}"
  end

end
