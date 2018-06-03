class RemovePictureFileNameToReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :picture_file_name, :string
    remove_column :reviews, :picture_content_type, :string
    remove_column :reviews, :picture_file_size, :int
    remove_column :reviews, :picture_updated_at, :datetime
  end
end
