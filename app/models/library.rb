class Library < ActiveRecord::Base
	#setting primary key with uniq value
	self.primary_key = 'red_id'
	#association with user
	belongs_to :user
	#validations
	validates :purchased_on, :user_id, :presence => { message: "purchase date and user id both are required"}

	#increament req id
	before_save :increment_req_id_value


	def self.to_csv(libraries)
		CSV.generate(headers: true) do |csv|
      csv << ["ref_id", "purchased_on", "in_possession_of", "description" ]

      libraries.each do |li|
        csv << [li.red_id, li.purchased_on, li.user.email, li.description]
      end
    end
	end


	private

	def increment_req_id_value
		 self.red_id = Library.order(:red_id).last.red_id.to_i + 1
	end
end
