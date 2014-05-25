class Activity < ActiveRecord::Base
  has_many :mesajes
    has_many :user_acts
	has_many :users, :through => :user_acts
    belongs_to :cathegory
    belongs_to :location
    
    
end
