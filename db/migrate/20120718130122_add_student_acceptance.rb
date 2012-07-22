class AddStudentAcceptance < ActiveRecord::Migration
  def self.up
    add_column :students, :acceptance, :integer, :default => 0
  end

  def self.down
    remove_column :students, :acceptance
  end
end
