class Library < ActiveRecord::Base
	#setting primary key with uniq value
	set_primary_key = "red_id"
	#association with user
	belongs_to :user
	#validations
	validates :purchased_on, :user_id, :presence => true

	#increament req id
	before_save :increment_req_id_value


	private

	def increment_req_id_value
		self.red_id = self.red_id.to_i + 1
	end
end
