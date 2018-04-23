class RankingController < ApplicationController
  layout 'review_site'
  before_action :ranking
  def ranking
    @ranking = Place.limit(10)
end
