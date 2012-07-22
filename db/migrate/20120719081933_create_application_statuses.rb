class CreateApplicationStatuses < ActiveRecord::Migration
  def self.up
    create_table :application_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
  
  def self.down
    drop_table :application_statuses
  end
  
end
