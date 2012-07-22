class CreateStudentFiles < ActiveRecord::Migration
  def self.up
    create_table :student_files do |t|
      t.string :name
      t.integer :student_id
    end
  end
  
  def self.down
    drop_table :student_files
  end
  
end
