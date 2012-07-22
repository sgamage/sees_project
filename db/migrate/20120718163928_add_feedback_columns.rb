class AddFeedbackColumns < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :extra_note, :text
    add_column :feedbacks, :read_confirmation, :boolean, :default => false
    add_column :feedbacks, :recommandation_level, :string
  end

  def self.down
    remove_column :feedbacks, :extra_note
    remove_column :feedbacks, :read_confirmation
    remove_column :feedbacks, :recommandation_level
  end
end
