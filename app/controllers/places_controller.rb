class PlacesController < ApplicationController
  before_action :set_place, only: :show
  before_action :authenticate_user!, only: :create

  def index
    @google_api_key = Rails.application.secrets.google_api_key
    @google_map_key = Rails.application.secrets.google_map_key
    @places = Place.order("created_at DESC")
    # place_ids = Review.where("rank >= 4").group(:place_id).order('count_place_id DESC').limit(8).count(:place_id).keys
    # @ranking = place_ids.map { |id| Place.find(id) }
  end

  def list
    @place = Place.all
    keyword = params[:search]
    @places = Place.includes(:reviews).where('name LIKE ? or address LIKE ?', "%#{keyword}%", "%#{keyword}%").references(:place)
    @client = GooglePlaces::Client.new( Rails.application.secrets.google_api_key )
    @cafes = @client.spots_by_query( keyword, :types => 'cafe', :language=>'ja')
  end

  def show
    @hash = Gmaps4rails.build_markers(@place) do |place,marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def search
    @places = Place.includes(:reviews).where('name LIKE ? or address LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%").references(:place)
  end


  def create
    @place = Place.new(place_params)
    @place.save
    @p = Place.where(address: @place.address)
    redirect_to new_place_review_path(@p.ids)
  end

  # def destroy
  #   @place.destroy

  #   respond_to do |format|
  #     format.html { redirect_to places_path, notice: "#{@place.name} を削除しました。"}
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :latitude, :longitude, :address, :photos)
    end
end
