class Review < ApplicationRecord

  validates :rank, presence: true
  validates :review, presence: true
  belongs_to :user
  belongs_to :place
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :photos
  accepts_nested_attributes_for :photos
  before_destroy :clean_s3


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

    private
      def clean_s3
        photos.remove!
        photos.thumb.remove!
      rescue Excon::Errors::Error => error
        puts "エラーです。"
        false
      end
end
