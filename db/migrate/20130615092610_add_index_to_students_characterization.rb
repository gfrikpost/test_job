class AddIndexToStudentsCharacterization < ActiveRecord::Migration
  def change
    add_index :students, :characterization, :length => 100
  end
end
