class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #attar accessor parameters :confirmable, :lockable, :timeoutable and :omniauthabl

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]


  attr_accessor :login

   #associations
   has_many :libraries, dependent: :destroy
   #validations
   validates :email, :presence => { message: "email is required" }
   validates :username, uniqueness: { case_sensitive: false }, presence: { message: "username is required" }

   #call back
   before_save :update_user_type

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

   def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
   end



   private

    def update_user_type
    	if self.admin
    		self.user_type = "admin"
    	else
    		self.user_type = "normal"
    	end
    end
end
