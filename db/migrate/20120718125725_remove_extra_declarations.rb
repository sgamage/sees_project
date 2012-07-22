class RemoveExtraDeclarations < ActiveRecord::Migration
  def up
    remove_column :students, :declaration2
    remove_column :students, :declaration3
    remove_column :students, :declaration4
  end

  def down
    add_column :students, :declaration2, :integer
    add_column :students, :declaration3, :integer
    add_column :students, :declaration4, :integer
  end
end
