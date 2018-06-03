class RemoveUserIdToPlaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :user_id, :int
    remove_column :places, :review, :text
  end
end
