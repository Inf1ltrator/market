class User < ActiveRecord::Base

	has_one  :cart
	has_many :orders
	has_many :comments
	
end
