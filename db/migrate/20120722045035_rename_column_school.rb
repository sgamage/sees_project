class RenameColumnSchool < ActiveRecord::Migration
  def self.up
    rename_column :schools, :postcose, :postcode
  end

  def self.down
    rename_column :schools, :postcode, :postcose
  end
end
