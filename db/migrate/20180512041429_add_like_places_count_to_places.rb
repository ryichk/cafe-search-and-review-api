class AddLikePlacesCountToPlaces < ActiveRecord::Migration[5.1]
  class MigrationUser < ApplicationRecord
    self.table_name = :places
  end
  def up
    _up
  rescue => e
    _down
    raise e
  end

  def down
    _down
  end

    private
      def _up
        MigrationUser.reset_column_information

        add_column :places, :like_places_count, :integer, null: false, dafault: 0 unless column_exists? :places, :like_places_count
      end

      def _down
        MigrationUser.reset_column_information

        remove_column :places, :like_places_count if column_exists? :places, :like_places_count
      end
end
