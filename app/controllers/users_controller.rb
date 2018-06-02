class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @username = current_user.username
    @reviews = current_user.reviews.includes(:place).order("created_at DESC")
  end

end
