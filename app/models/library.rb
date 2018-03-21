class Library < ActiveRecord::Base
	#setting primary key with uniq value
	set_primary_key :red_id
	#association with user
	belongs_to :user
end
