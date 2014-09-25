class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def is_authenticated?
    render json: {} unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end


	def twitter_call term
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
		  config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
		  config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
		  config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
		end

		result = client.search(term)
		return result
	end
end
