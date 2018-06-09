class AddPhotosTmpToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :photos_tmp, :string
  end
end
