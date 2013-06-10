class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :surname
      t.integer :group_id
      t.date :dob
      t.string :email
      t.string :ip
      t.decimal :gpa
      t.text :characterization

      t.timestamps
    end
  end
end
