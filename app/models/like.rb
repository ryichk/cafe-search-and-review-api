class Like < ApplicationRecord
  belongs_to :review
  belongs_to :user
  counter_culture :review, column_name: :likes_count, delta_magnitude: 1
  validates :user_id, presence: true
  validates :review_id, presence: true
end
