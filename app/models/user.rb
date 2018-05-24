class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable
  validates :username, presence: true
  validates :agreement, presence: true
  validates_acceptance_of :agreement, allow_nil: false, message: "＊ユーザー登録には利用規約への同意が必要です。", on: :create
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :like_places, dependent: :destroy
  # belongs_to :place

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
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
                         agreement: 1
                         )
    end
    user
  end

  def self.find_for_instagram_for_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.info.nickname,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: User.create_unique_email,
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

      def self.find_for_oauth(auth)
        user = User.where(uid: auth.uid, provider: auth.provider).first

        unless user
          user = User.create(
            uid:      auth.uid,
            provider: auth.provider,
            email:    User.dummy_email(auth),
            password: Devise.friendly_token[0, 20]
          )
        end

        user
      end

      def self.dummy_email(auth)
        "#{auth.uid}-#{auth.provider}@example.com"
      end
end
