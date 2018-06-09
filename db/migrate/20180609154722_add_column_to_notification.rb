class AddColumnToNotification < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :notified_by, index: true
    add_foreign_key :notifications, :users, column: :notified_by_id
  end
end
