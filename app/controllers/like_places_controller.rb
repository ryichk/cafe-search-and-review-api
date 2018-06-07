class LikePlacesController < ApplicationController
  before_action :authenticate_user!

  def index
    @like_place = LikePlace.includes(:place).where(user_id: current_user.id).references(:like_place)
  end

  def create
    @place = Place.find(params[:place_id])
    unless @place.good?(current_user)
      @place.good(current_user)
      @place.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @place = LikePlace.find(params[:id]).place
    if @place.good?(current_user)
      @place.ungood(current_user)
      @place.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
