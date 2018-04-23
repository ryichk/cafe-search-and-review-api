class ReviewsController < ApplicationController
  before_action :move_to_users_session, only: [:new, :destroy]

  def index
    @reviews = Review.includes(:user).order("created_at DESC")
  end

  def new
  end

  def create
    Review.create(review: review_params[:review], rank: review_params[:rank], photos: review_params[:photos], user_id: current_user.id)
  end


    private
      def review_params
        params.permit(:review, :rank, :photos)
      end

      def move_to_users_session
      redirect_to new_user_session_path unless user_signed_in?
    end
end
