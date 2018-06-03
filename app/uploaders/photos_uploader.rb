class PhotosUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # iPhoneから画像を投稿した際に、画像の向きがおかしい場合があるので、
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

  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png JPG JPEG GIF PNG)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    '#{secure_token(10)}.#{file.extension}' if original_filename.present?
  end

    protected

      def secure_token(length=16)
        var = :"@#{mounted_as}_secure_token"
        model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
      end

      # Create different versions of your uploaded files:
      version :thumb do
        process resize_to_fit: [50, 50]
      end


end
