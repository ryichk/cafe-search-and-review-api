class ReviewsController < ApplicationController
  before_action :move_to_users_session, only: [:new, :destroy]

  def index
    @reviews = Review.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @place = Place.find(params[:place_id])
    @review = Review.new
  end

  def create
    Review.create(create_params)
    redirect_to controller: :places, action: :index
  end


    private
      def create_params
        params.require(:review).permit(:review, :rank, :photos).merge(place_id: params[:place_id])
      end

      def move_to_users_session
        redirect_to new_user_session_path unless user_signed_in?
      end
end
