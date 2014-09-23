module SessionsHelper

	def signed_in?
		!!current_user
	end

	def sign_in(user)
	 	session[:user_id] = user.id
	 	@current_user = user
	end

	def current_user
		@current_user = @current_user || User.find(session[:user_id])
	end
end
