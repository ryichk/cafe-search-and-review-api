class Review < ApplicationRecord

  validates :rank, presence: true
  validates :review, presence: true
  belongs_to :user
  belongs_to :place
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  mount_uploaders :photos, PhotosUploader
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

  def self.create_photos_by(create_params)
    Review.transaction do
      create_params[:photos].each do |photo|
        new_photo = Review.new(review: create_params[:review], rank: create_params[:rank], photos: photo, user_id: create_params[:user_id], place_id: create_params[:place_id])
        return false unless new_photo.save!
      end
    end
    true
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
