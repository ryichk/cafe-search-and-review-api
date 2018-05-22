Rails.application.config.middleware.use OmniAuth::Builder do
  # facebook scopeを指定し、使用する権限を明記する必要があります
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret_key, scope: 'email,status_update,publish_actions'
  # Twitter
  provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret
  # Instagram
  provider :instagram, Rails.application.secrets.instagram_client_id, Rails.application.secrets.instagram_client_secret
end

#キャンセル
OmniAuth.config.on_failure = Proc.new do |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end