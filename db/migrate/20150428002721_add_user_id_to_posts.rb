class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_timestamps :posts
    add_timestamps :users
  end
end
