class FixPostCategory < ActiveRecord::Migration
  def change
    remove_column :post_categories, :posts_id
    remove_column :post_categories, :categories_id
    add_column :post_categories, :post_id, :integer
    add_column :post_categories, :category_id, :integer
    add_column :post_categories, :created_at, :datetime
    add_column :post_categories, :updated_at, :datetime
  end
end
