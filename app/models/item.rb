class Item < ActiveRecord::Base

	attr_accessor :price, :name

	validates :price,  :numericality => { :greater_then => 0 } 
	
end

