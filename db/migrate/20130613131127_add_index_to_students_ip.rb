class AddIndexToStudentsIp < ActiveRecord::Migration
  def change
    add_index :students, :ip, :length => 20
  end
end
