class AddColumnsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :course_code, :string
    add_column :courses, :faculty_name, :string
  end

  def self.down
    remove_column :courses, :course_code
    remove_column :courses, :faculty_name
  end
end
