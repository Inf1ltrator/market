class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
    if @user != current_user
      render_403
    end
  end
end
