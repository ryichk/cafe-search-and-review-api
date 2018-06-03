class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.references :review, index: true
      t.string :photos
      t.timestamps
    end
  end
end
