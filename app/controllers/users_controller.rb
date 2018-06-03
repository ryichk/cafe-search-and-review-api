class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @reviews = Review.includes(:place).order("created_at DESC")
  end

end
