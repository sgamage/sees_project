class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.belongs_to :category
      t.string :question_text

      t.timestamps
    end
  end
  
  def self.down
    drop_table :questions
  end
  
end
