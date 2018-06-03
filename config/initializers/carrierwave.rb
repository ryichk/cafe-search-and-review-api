# # require 'carrierwave/storage/abstract'
# # require 'carrierwave/storage/file'
# # require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: Rails.application.secrets.AWS_ACCESS_KEY_ID,
#     aws_secret_access_key: Rails.application.secrets.AWS_SECRET_ACCESS_KEY,
#     region: Rails.application.secrets.AWS_REGION
#   }

#   # キャッシュもS3に置くようにする
#   config.cache_storage = :fog
#   config.cache_dir = 'tmp/image-cache'

#   # S3バケット名
#   config.fog_directory = Rails.application.secrets.AWS_S3_BUCKET
#   config.asset_host = Rails.application.secrets.AWS_S3_URL
# end

#   # 日本語の文字化けを防ぐ
# CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/