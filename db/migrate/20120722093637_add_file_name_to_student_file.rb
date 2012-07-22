class AddFileNameToStudentFile < ActiveRecord::Migration
  def self.up
    add_column :student_files, :display_name, :text
  end

  def self.down
    remove_column :student_files, :display_name
  end
end
