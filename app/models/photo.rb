class Photo < ApplicationRecord
  belongs_to :review
  mount_uploaders :photos, PhotosUploader
end
