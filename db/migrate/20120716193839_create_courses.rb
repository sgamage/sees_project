class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.belongs_to :faculty
    end
  end
  
  def self.down
    drop_table :courses
  end
  
end
