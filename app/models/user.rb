class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable
  validates :username, length: { in: 2..8, too_long: "最大%{count}文字までです。", too_short: "最低限%{count}文字必要です" }, presence: true
  validates :agreement, presence: true
  validates_acceptance_of :agreement, allow_nil: false, message: "＊ユーザー登録には利用規約への同意が必要です。", on: :create
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :like_places, dependent: :destroy
  # belongs_to :place

  mount_uploader :avatar_url, AvatarUrlUploader
  before_destroy :clean_s3

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         avatar_url: auth.info.image,
                         password: Devise.friendly_token[0,20],
                         agreement: 1
                         )
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.info.nickname,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: User.create_unique_email,
                         password: Devise.friendly_token[0,20],
                         agreement: 1,
                         avatar_url: auth.info.image
                         )
    end
    user.skip_confirmation!
  end

  def self.find_for_instagram_for_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: User.info.email,
                         avatar_url: auth.info.image,
                         password: Devise.friendly_token[0,20],
                         agreement: 1
                         )
    end
    user
  end

    private
    # 通常サインアップ時のuid用、Twitter OAuth認証時のemail用にuuidな文字列を生成
      def self.create_unique_string
        SecureRandom.uuid
      end

      # twitterではemailを取得できないので、適当に一意のemailを生成
      def self.create_unique_email
        User.create_unique_string + "@example.com"
      end

      def self.dummy_email(auth)
        "#{auth.uid}-#{auth.provider}@example.com"
      end

      def clean_s3
        avatar_url.remove!
        avatar_url.thumb.remove!
      rescue Excon::Errors::Error => error
        puts "エラーです"
        false
      end
end
