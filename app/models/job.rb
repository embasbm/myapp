class Job < ActiveRecord::Base
  
  validates :name, presence: true, length: { minimum: 1  }
  
  attr_accessible :name, :predecessor_id
  
  has_one :predecessor, class_name: "Job", foreign_key: :predecessor_id
  belongs_to :dependent, class_name: "Job", foreign_key: :predecessor_id
  
end
