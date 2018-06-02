class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @username = current_user.username
    @reviews = Review.includes(:place)
  end

end
