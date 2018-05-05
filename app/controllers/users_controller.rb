class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @username = current_user.username
    @reviews = current_user.reviews
    @reviews.each do |review|
      @places = Place.where(id: review.place_id)
    end
  end

end
