class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :parent_name
      t.string :parent_phone
      t.string :parent_mobile
      t.string :uac_number
      t.string :email
      t.string :confirm_email
      t.string :mobile
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :suburb
      t.belongs_to :state
      t.string :post_code
      t.belongs_to :school
      t.belongs_to :faculty
      t.belongs_to :course
      t.string :note1
      t.string :note2
      t.string :note3
      t.boolean :declaration1
      t.boolean :declaration2
      t.boolean :declaration3
      t.boolean :declaration4
      t.boolean :completed, :default => false
      t.integer :user_id, :default => nil
      t.timestamps
    end
    
    def self.down
      drop_table :students
    end
    
  end
end
