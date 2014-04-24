class Job < ActiveRecord::Base
  
  validates :name, presence: true, length: { minimum: 1  }
  
  attr_accessible :name, :predecessor_id
  
end
