class User < ActiveRecord::Base

	has_secure_password

	has_many :reviews, dependent: :destroy
	has_many :events, dependent: :destroy


	validates :username,
		:uniqueness => true,
		:presence => {:message=> 'Field cannot be left blank'}

	validates :email,
		:presence => {:message=> 'Field cannot be left blank'},
		:uniqueness => true,
		:format => {:with => /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/}

	validates :password_digest,
		:presence => {:message=> 'Field cannot be left blank'},
		:confirmation => true,
		:length => { minimum: 6 }, on: :create

	def set_password_reset
	  self.code = SecureRandom.urlsafe_base64
	  self.expires_at = 4.hours.from_now
	  self.save!
	end

	def self.authenticate username, password
		User.find_by_username(username).try(:authenticate,password)
	end


end