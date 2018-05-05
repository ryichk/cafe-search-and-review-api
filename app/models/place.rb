class Place < ApplicationRecord
  geocoded_by :name
  after_validation :geocode

  has_many :reviews
  validates :address, uniqueness: true

  def review_average
    average = self.reviews.average(:rank).round(1)
    if average == 0
      average = 0
    elsif average > 0 && average <= 0.7
      average = 0.5
    elsif average > 0.7 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 1.7
      average = 1.5
    elsif average > 1.7 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 2.7
      average = 2.5
    elsif average > 2.7 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 3.7
      average = 3.5
    elsif average > 3.7 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 4.7
      average = 4.5
    elsif average > 4.7 && average <= 5
      average = 5
    end
  end
end
