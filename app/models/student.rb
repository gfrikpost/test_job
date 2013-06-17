class Student < ActiveRecord::Base
  attr_accessible :characterization, :dob, :email, :gpa, :group_id, :ip, :name, :surname
  
  belongs_to :group # устанавливаем соединение один к одному с моделью Группа
  has_many :evaluations # устанавливаем соединение один ко многим с моделью Оценка
  has_many :subjects, through: :evaluations # устанавливаем соединение многие ко многоим с моделью Оценка через модель Предмет
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # Регулярное вырожение проверки валидности поля email
  
  validates :name, presence: true, length: { maximum: 50 } # поле name должно быть заполненно и содержать не более 50 символов
  validates :surname, presence: true, length: { maximum: 50 } # поле surname должно быть заполненно и содержать не более 50 символов
  validates :dob, presence:true # поле дата рождения должно быть заполнено
  validates :email, :presence  => true,
                    :format    => { :with => email_regex } # поле email должно быть заполнено и соответвовать регулярному вырожению

  default_scope order: 'students.gpa DESC' # Стандартный порядок получения данныйх из бд по наивысшему среднему балу
  
  scope :with_surname, ->(surname) { where("surname = ?", surname) } # Скоупы для работы фильтра предотвращающие sql иньекции
  scope :with_group_id, ->(group_id) { where("group_id = ?", group_id) }
  scope :if_gpa_greater_or_equal, ->(gpa_greater_or_equal) { where("gpa >= ?", gpa_greater_or_equal)}
  scope :if_gpa_less_or_equal, ->(gpa_less_or_equal) { where("gpa <= ?", gpa_less_or_equal)}

  def self.name_surname_id
    all.collect { |student| [ student.surname + " " + student.name, student.id] } # Получаем массив для заполнения поля select
  end

  
  def self.ip_charcterization                              
  # метод возвращает коллекцию студентов,c IP которых произошло более одной регистрации,
  # и при этом хотя бы у одного из них написана характеристика
  find_by_sql("SELECT * FROM students WHERE ip              
                IN (SELECT ip FROM students GROUP BY ip
                HAVING COUNT(*)>1) AND ip = ANY
                (SELECT ip FROM students WHERE
                characterization NOT LIKE '') ORDER BY ip")
    
  end
  
end
