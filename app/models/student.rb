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
   
  def self.filter(params)
    @param_without_nil = params.delete_if {|key, value|
      (value.blank?)
    }
    @sql = []
    @param_without_nil.each{|key, value|
      if key == "surname"
       @sql << "surname = '#{value}'"
      end
      if key == "group_id"
        @sql << "group_id = '#{value}'"
      end
      if key == "gpa_greater_or_equal"
        @sql << "gpa >= #{value}"
      end
      if key == "gpa_less_or_equal"
        @sql << "gpa <= #{value}"
      end
    }
    @sql = @sql.join(" AND ")
    return @sql
  end
  
  def self.ip_charcterization
    @duplicates = Student.find( :all,
      :select     => "ip , COUNT(ip) AS duplicate_count",
      :conditions => "ip IS NOT NULL AND ip !=''",
      :group      => "ip HAVING duplicate_count > 1"
    )
    
    @ip = []
    
    @duplicates.each do |dup|
      @ip << dup.ip
    end
    
    @students = Student.where("characterization != ''", :ip => @ip).all
    
    return @students
  end
  
end
