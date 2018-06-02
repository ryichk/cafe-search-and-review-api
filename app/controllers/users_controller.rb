class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = current_user.id
    @reviews = Review.includes(:place).where(user_id: id).references(:review)
  end

end
