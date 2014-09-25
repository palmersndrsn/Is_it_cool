class Event < ActiveRecord::Base

	has_many :reviews, dependent: :destroy
	belongs_to :user

	validates :name,
		:uniqueness => true,
		:presence => {:message=> 'Field cannot be left blank'}

	validates :hashtag,
		:uniqueness => true,
		:presence => {:message=> 'Field cannot be left blank'}

	validates :desc,
		:presence => {:message=> 'Field cannot be left blank'}

end
