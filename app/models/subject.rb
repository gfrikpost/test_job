class Subject < ActiveRecord::Base
  attr_accessible :name
  
  has_many :evaluations
  
  validates :name, presence: true, length: { maximum: 50 }
end
