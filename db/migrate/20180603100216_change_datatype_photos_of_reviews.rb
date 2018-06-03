class ChangeDatatypePhotosOfReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :photos, :json
  end
end
