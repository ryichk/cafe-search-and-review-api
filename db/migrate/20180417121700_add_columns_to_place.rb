class AddColumnsToPlace < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :user_id, :integer
    add_column :places, :review, :text
    add_column :places, :photos, :string
  end
end
