class Student < ActiveRecord::Base
  attr_accessible :characterization, :dob, :email, :gpa, :group_id, :ip, :name, :surname
  
  belongs_to :group
  has_many :evaluations
  has_many :subjects, through: :evaluations
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  validates :dob, presence:true
  validates :email, :presence  => true,
                    :format    => { :with => email_regex }
                    
  default_scope order: 'students.gpa DESC'
                    
  def self.name_surname_id
    all.collect { |student| [ student.surname + " " + student.name, student.id] }
  end
  
end
