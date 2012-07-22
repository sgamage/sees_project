class AddApplicationSupportColumns < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :support_student, :boolean, :default => false
    add_column :feedbacks, :application_support_status_id, :integer
    add_column :feedbacks, :application_support_comment, :text
  end

  def self.down
    remove_column :feedbacks, :support_student
    remove_column :feedbacks, :application_support_status_id
    remove_column :feedbacks, :application_support_comment
  end
end
