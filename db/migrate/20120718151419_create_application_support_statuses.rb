class CreateApplicationSupportStatuses < ActiveRecord::Migration
  def self.up
    create_table :application_support_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
  
  def self.down
    drop_table :application_support_statuses
  end
  
end
