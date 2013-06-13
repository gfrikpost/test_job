class AddIndexToStudentsName < ActiveRecord::Migration
  def change
    add_index :students, :name, :length => 100
  end
end
