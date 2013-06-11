class ChangeTypeForStudentGpa < ActiveRecord::Migration
  def up
    change_table :students do |t|
      t.change :gpa, :decimal, :precision => 8, :scale => 2
    end
  end

  def down
    change_table :students do |t|
      t.change :gpa, :decimal, :precision => 8, :scale => 2
    end
  end
end
