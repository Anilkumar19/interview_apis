class UserMailer < ApplicationMailer
	layout false
	default from: "your mail id here (user name)"

	def welcome_user(user, params)

		mail :to => user.email, :subject => title
	end

	
end