class Review < ApplicationRecord

  validates :rank, presence: true
  validates :review, presence: true
  belongs_to :user
  belongs_to :place
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  if Rails.env.production?
    mount_uploaders :photos, PhotosUploader
    process_in_background :photos
    store_in_background :photos
  end



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
