class UsersController < ApplicationController
  etag { current_user.try(:id) }
  before_action :authenticate_user!, only: :show
  def index
    @users = User.page(params[:page]).order("created_at DESC").per(30)
    fresh_when(@users)
  end

  def search
    @users = User.where('username LIKE ?', "%#{params[:search_user]}%").limit(25)
    fresh_when(@users)
  end

  def show
    @user = User.includes(reviews: :place).find(params[:id])
    fresh_when(@user)
  end

end
