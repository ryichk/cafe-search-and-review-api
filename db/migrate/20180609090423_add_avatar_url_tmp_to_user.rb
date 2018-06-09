class AddAvatarUrlTmpToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar_url_tmp, :string
  end
end
