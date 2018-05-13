class LikePlacesController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    unless @place.good?(current_user)
      @place.good(current_user)
      @place = Place.find(params[:place_id])
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
