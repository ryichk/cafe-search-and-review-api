class Like < ApplicationRecord
  belongs_to :review, touch: true
  belongs_to :user
  has_many :notifications, dependent: :destroy

  counter_culture :review, column_name: :likes_count, delta_magnitude: 1
  validates :user_id, presence: true
  validates :review_id, presence: true
end
