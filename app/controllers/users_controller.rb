class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  def index
    @users = User.page(params[:page]).per(30)
  end

  def search
    @users = User.where('username LIKE ?', "%#{params[:search_user]}%").limit(15)
  end

  def show
    @user = User.includes(reviews: :place).find(params[:id])
  end

end
