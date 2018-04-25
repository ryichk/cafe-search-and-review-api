class Review < ApplicationRecord

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :avatar, content_type: ["image/jpg","image/jpeg","image/png"]
  belongs_to :user
  belongs_to :place
end
