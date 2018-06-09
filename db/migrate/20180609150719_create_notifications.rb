class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :review, index: true, foreign_key: true
      t.string :notified_type
      t.boolean :read, default: false

      t.timestamps
    end

  end
end
