class Evaluation < ActiveRecord::Base
  attr_accessible :evaluation, :semestr, :student_id, :subject_id
  
  belongs_to :subjects
  belongs_to :students
  
  validates :evaluation, presence: true, length: { minimum: 1, maximum: 5 }
  validates :semestr, presence: true, length: { minimum: 1, maximum: 2 }
  
  SEMESTERS = [ 1, 2]
  EVALUATIONS = [1, 2, 3, 4, 5]
  
  def self.gpa_for_student(student_id)           # метод вычисляет средний балл по предметам
    student = Student.find_by_id(student_id)     # из таблицы оценки для соответствующего id студента
    collect_eval = student.evaluations.all.collect{ |eval| eval.evaluation }
    summ = collect_eval.each.sum                 # и записывает его в таблицу студенты
    subject_count = collect_eval.count
    gpa = summ/(subject_count).to_f
    student.gpa = gpa
    student.save
  end
end
