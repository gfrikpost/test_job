class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :students
  
  validates :name, presence: true, length: { maximum: 50 }
end
