class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :destroy]

  before_action :move_to_users_session, only: [:create, :destroy]



  def index
    @google_api_key = Rails.application.secrets.google_api_key
    @google_map_key = Rails.application.secrets.google_map_key
    @places = Place.order("created_at DESC").page(params[:page]).per(20)
    place_ids = Review.group(:place_id).order('count_place_id DESC').limit(7).count(:place_id).keys
    @ranking = place_ids.map { |id| Place.find(id) }
  end

  def list
    keyword = params[:search]
    @client = GooglePlaces::Client.new( ENV['GOOGLE_API_KEY'] )
    @places = @client.spots_by_query( keyword, :types => 'cafe', :language=>'ja')
    @place = Place.all
  end

  def show
    @hash = Gmaps4rails.build_markers(@place) do |place,marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def search
    @places = Place.where('name LIKE ?', "%#{params[:keyword]}%").limit(15)
  end


  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to places_path, notice: "#{@place.name} を登録しました" }
      else
        format.html { render :index, notice: "すでに登録されているため登録できませんでした" }
      end
    end
  end

  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_path, notice: "#{@place.name} を削除しました。"}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :latitude, :longitude, :address, :photos)
    end

    def move_to_users_session
      redirect_to new_user_session_path unless user_signed_in?
    end

end
