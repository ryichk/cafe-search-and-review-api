class PlaceController < ApplicationController
  before_action :set_place, only: [:show, :destroy]

  before_action :move_to_users_session, only: [:create, :destroy]



  def index
    @places = Place.all
  end

  def list
    keyword = params[:search]
    @client = GooglePlaces::Client.new( ENV['GOOGLE_API_KEY'] )
    @places = @client.spots_by_query( keyword, :types => 'cafe' )
  end

  def show
    @hash = Gmaps4rails.build_markers(@place) do |place,marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to place_index_path, notice: "#{@place.name} を登録しました" }
      else
        format.html { render :index, notice: "#{@place.name} を登録できませんでした" }
      end
    end
  end

  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to place_index_path, notice: "#{@place.name} を削除しました。"}
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
