class Review < ApplicationRecord

  has_attached_file :picture, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :picture, content_type: ["image/jpg","image/jpeg","image/png"]
  validates :rank, presence: true
  validates :review, presence: true
  belongs_to :user
  belongs_to :place
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  # レビューにいいねをする
  def like(user)
    likes.create(user_id: user.id)
  end

  # レビューのいいねを解除する
  def dislike(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしていたらtrueを返す
  def like?(user)
    like_users.include?(user)
  end
end
