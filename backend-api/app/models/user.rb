class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable
  validates :username, length: { in: 2..10, too_long: "最大%{count}文字までです。", too_short: "最低限%{count}文字必要です" }, presence: true
  validates :agreement, presence: true
  validates_acceptance_of :agreement, allow_nil: false, message: "＊ユーザー登録には利用規約への同意が必要です。", on: :create
  has_many :reviews
  has_many :likes
  has_many :like_places
  has_many :notifications
  # belongs_to :place
  if Rails.env.production?
    mount_uploader :avatar_url, AvatarUrlUploader
    # process_in_background :avatar_url
    # store_in_background :avatar_url
  end
  before_destroy :clean_s3

    private
    # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
      def self.create_unique_string
        SecureRandom.uuid
      end

      def clean_s3
        avatar_url.remove!
        avatar_url.thumb.remove!
      rescue Excon::Errors::Error => error
        puts "エラーです"
        false
      end
end
