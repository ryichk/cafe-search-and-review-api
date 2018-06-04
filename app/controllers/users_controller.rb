class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
    @users = User.all
  end

  def show
    @reviews = Review.includes(:place).where(user_id: current_user.id).references(:review).order("created_at DESC")
  end

end
