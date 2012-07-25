class RevertDeclarationColumns < ActiveRecord::Migration
  def self.up
    #add_column :students, :declaration2, :integer
    #add_column :students, :declaration3, :integer
    #add_column :students, :declaration4, :integer
  end

  def self.down
    remove_column :students, :declaration2
    remove_column :students, :declaration3
    remove_column :students, :declaration4	  
  end
end
