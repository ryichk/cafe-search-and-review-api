class LikePlace < ApplicationRecord
  belongs_to :user
  belongs_to :place
  counter_culture :place, column_name: :like_places_count, delta_magnitude: 1
  validates :user_id, presence: true
  validates :place_id, presence: true
end
