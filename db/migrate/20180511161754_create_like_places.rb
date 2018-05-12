class CreateLikePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :like_places do |t|
      t.integer :user_id, null: false
      t.integer :place_id, null: false

      t.timestamps

      t.index :user_id
      t.index :place_id
      t.index [:user_id, :place_id], unique: true
    end
  end
end
