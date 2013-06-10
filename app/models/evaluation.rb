class Evaluation < ActiveRecord::Base
  attr_accessible :evaluation, :semestr, :student_id, :subject_id
  
  belongs_to :subjects
  belongs_to :students
  
  validates :evaluation, precence: true, length: { minimum: 1, maximum: 5 }
  validates :semestr, precence: true, length: { minimum: 1, maximum: 2 }
end
