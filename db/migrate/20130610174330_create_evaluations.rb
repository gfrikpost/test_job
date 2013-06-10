class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :student_id
      t.integer :subject_id
      t.integer :semestr
      t.integer :evaluation

      t.timestamps
    end
  end
end
