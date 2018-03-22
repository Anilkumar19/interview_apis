class UserMailer < ApplicationMailer
	layout false
	default from: "your mail id here (user name)(it is for gmail setting)"

	def welcome_user(user)
		@user = user
		title = "Welcome to the website"
		mail :to => user.email, :subject => title
	end

end