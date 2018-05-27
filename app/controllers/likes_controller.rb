class LikesController < ApplicationController
  before_action :move_to_users_session, only: [:create, :destroy]

  def create
    @review = Review.find(params[:review_id])
    if user_signed_in?
      unless @review.like?(current_user)
        @review.like(current_user)
        @review.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to user_session_path
    end
  end

  def destroy
    @review = Like.find(params[:id]).review
    if user_signed_in?
      if @review.like?(current_user)
        @review.dislike(current_user)
        @review.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to user_session_path
    end
  end
end
