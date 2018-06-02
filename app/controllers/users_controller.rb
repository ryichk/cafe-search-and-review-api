class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id_user = current_user.id
    @reviews = Review.includes(:place).references(:review).where(user_id: id_user)
  end

end
