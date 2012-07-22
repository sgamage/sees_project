class Addapplicationstatusidtostudent < ActiveRecord::Migration
  def self.up
    add_column :students, :application_status_id, :integer
  end

  def self.down
    remove_column :students, :application_status_id 
  end
end
