class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
    @users = User.all
  end

  def show
    @user = User.includes(reviews: :place).find(params[:id])
  end

end
