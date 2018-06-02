class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @reviews = Review.includes(:place).where("user_id = ?", current_user.id).references(:review)
  end

end
