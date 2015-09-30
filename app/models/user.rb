class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :cart
  has_one :image, as: :imageable
  has_many :comments, as: :commentable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create{
    self.cart = Cart.create() 
    self.image = Image.create()
  }

  before_destroy{
    self.cart.destroy
    self.image.destroy
  }

end
