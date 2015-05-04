class CreatePostCategory < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.integer :posts_id
      t.integer :categories_id
    end
  end
end
