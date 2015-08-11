class Item < ActiveRecord::Base

	validates :price,  :numericality => { :greater_then => 0, :allow_nil => true} 
	validates :name, :presence => true

	belongs_to :category
	has_many :positions
	has_many :carts, through: :positions
	has_many :comments, as: :commentable
	has_one :image, as: :imageable
	after_initialize{}
	after_save{}
	#after_create{ category.inc(:items_count,1) }
	after_update{}
	#after_destroy{ category.inc(:items_count,-1) }
end

