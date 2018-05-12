class Like < ApplicationRecord
  belongs_to :review
  belongs_to :user
  counter_culture :review
  validates :user_id, presence: true
  validates :review_id, presence: true
end
