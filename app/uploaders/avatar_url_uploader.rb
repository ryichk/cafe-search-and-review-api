class AvatarUrlUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # iPhoneから画像投稿した際に、画像の向きがおかしい場合があるので
  # Rmagickのauto_orientメソッドで向きを正す
  process :fix_rotate
  def fix_rotate
    manipulate! do |img|
      img = img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  # Choose what kind of storage to use for this uploader:
  # ストレージの設定（S3アップロード用にfogを指定)
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png JPG JPEG GIF PNG)
  end

  # Override the filename of the uploaded files:
  # ファイル名の設定（以下はランダムな１６進数文字列をファイル名の先頭に付与している例)
  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename
  end

    protected

      def sucure_token(length=16)
        var = :"@#{mounted_as}_secure_token"
        model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
      end

      # Create different versions of your uploaded files:
      # リサイズの設定（要RMagick)
      # 1つだけではなく複数のversionを設定可能
      version :thumb do
        process resize_to_fill: [50, 50]
      end





  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
