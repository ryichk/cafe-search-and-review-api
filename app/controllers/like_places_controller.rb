class LikePlacesController < ApplicationController

  def index
    @like_place = LikePlace.includes(:place).where(user_id: current_user.id).references(:like_place)
    fresh_when(@like_place)
  end

  def create
    @place = Place.find(params[:place_id])
    if user_signed_in?
      unless @place.good?(current_user)
        @place.good(current_user)
        @place.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to user_session_path
    end
    fresh_when(@place)
  end

  def destroy
    @place = LikePlace.find(params[:id]).place
    if user_signed_in?
      if @place.good?(current_user)
        @place.ungood(current_user)
        @place.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to user_session_path
    end
    fresh_when(@place)
  end
end
