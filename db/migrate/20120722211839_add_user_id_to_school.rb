class AddUserIdToSchool < ActiveRecord::Migration
  def self.up
    add_column :schools, :user_id, :integer
  end

  def self.down
    remove_column :schools, :user_id
  end
end
