class UserMailer < ApplicationMailer
	layout false
	default from: "your email user name"

	def welcome_user(user)
		@user = user
		title = "Welcome to the website"
		mail :to => user.email, :subject => title
	end

end