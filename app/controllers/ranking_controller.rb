class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
    place_ids = Review.group(:place_id).order('count_place_id DESC').limt(10).count(:place_id).keys
    @ranking = place_ids.map { |id| Place.find(id) }
  end
end
