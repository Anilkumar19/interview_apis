class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   #associations
   has_many :libraries
   #validations
   validates :email, :admin, :contact_number, :presence => true

   #call back
   before_save :update_user_type



   private

    def update_user_type
    	if self.admin
    		self.user_type = "admin"
    	else
    		self.user_type = "normal"
    	end
    end
end
