class AddColomnToSchool < ActiveRecord::Migration
 def self.up
   
    add_column :schools, :principal_title, :string        
    add_column :schools, :principal_firstname, :string
    add_column :schools, :principal_surname, :string
    add_column :schools, :position, :string
    add_column :schools, :address, :string
    add_column :schools, :suburb, :string
    add_column :schools, :state, :string
    add_column :schools, :postcose, :string
    add_column :schools, :phone, :string
    add_column :schools, :email, :string
    add_column :schools, :category, :string    

   
  end

  def self.down
    
    remove_column :schools, :principal_title, :principal_firstname, :principal_surname, :position, :address, :suburb, :state, :postcode, :phone, :email, :category
    
  end
end
