class School < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :students

  def display_title
    "#{name} (#{category})"
  end

end
