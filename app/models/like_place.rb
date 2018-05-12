class LikePlace < ApplicationRecord
  belongs_to :user
  belongs_to :place
  counter_culture :place
  validates :user_id, presence: true
  validates :place_id, presence: true
end
