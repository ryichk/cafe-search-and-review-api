class AddColumnToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :smoke, :int
    add_column :reviews, :wifi, :int
    add_column :reviews, :elec, :int
    add_column :reviews, :menu, :int
    add_column :reviews, :coffee, :int
    add_column :reviews, :cost, :int
  end
end
