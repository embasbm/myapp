class Job < ActiveRecord::Base
  attr_accessible :name, :predecessor_id
  
end
