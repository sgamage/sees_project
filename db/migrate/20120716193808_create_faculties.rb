class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
      t.string :name
      t.belongs_to :school
    end
  end
  
  def self.down
    drop_table :faculties
  end
  
  
end
