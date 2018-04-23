class UsersController < ApplicationController
  def index
  end
  def show
    @username = current_user.username
    @reviews = current_user.reviews
  end
end
