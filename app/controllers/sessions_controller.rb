class SessionsController < ApplicationController
	def create
		user = User.find_or_create_from_jawbone(env['omniauth.auth'])
		session[:user_id] = user.id
		redirect_to root_path, notice: "Signed in!"		
	end
end
