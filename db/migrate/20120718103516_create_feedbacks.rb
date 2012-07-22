class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.belongs_to :student
      t.belongs_to :user
      t.belongs_to :school
      t.string :answers
      t.timestamps
    end
  end
  
  def self.down
    drop_table :feedbacks
  end
  
end
