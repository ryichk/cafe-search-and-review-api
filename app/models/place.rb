class Place < ApplicationRecord
  geocoded_by :name
  after_validation :geocode

  has_many :reviews
  validates :address, uniqueness: true
end
