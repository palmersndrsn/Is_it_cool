class Review < ActiveRecord::Base

	belongs_to :user
	belongs_to :event

	validates :body,
		:presence => {:message=> 'Field cannot be left blank'}

	validates :ratio,
		:presence => {:message=> 'Field cannot be left blank'}

	validates :grime,
		:presence => {:message=> 'Field cannot be left blank'}

end
