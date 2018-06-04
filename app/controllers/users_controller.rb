class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
    @users = User.all
  end

  def show
    @user = User.includes(reviews: :place).find(params[:id])
    @reviews = Review.includes(:place).where(user_id: current_user.id).references(:review)
  end

end
