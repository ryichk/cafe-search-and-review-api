class LikesController < ApplicationController
  after_action :create_notifications, only: :create

  def create
    @review = Review.includes(:user).find(params[:review_id])
    if user_signed_in?
      unless @review.like?(current_user)
        @review.like(current_user)
        @review.reload
        respond_to do |format|
          format.html { redirect_to request.referrer }
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

    private
      def create_notifications
        @notification = Notification.create(user_id: @review.user.id, notified_by_id: current_user.id, review_id: @review.id, notified_type: 'いいね')
      end
end
