class CartsController < ApplicationController
  def show
    @cart = current_user.cart
  end

  def delete_position
    @position 
    @position.destroy
    render "show"
  end
end
