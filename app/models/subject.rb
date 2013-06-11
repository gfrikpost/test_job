class Subject < ActiveRecord::Base
  attr_accessible :name
  
  has_many :evaluations
  
  validates :name, presence: true, length: { maximum: 50 }
  
  def self.names_id
    all.collect { |subject| [subject.name, subject.id] }
  end
end
