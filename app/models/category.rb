class Category < ActiveRecord::Base
  include SluggableCgeb

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  sluggable_column :name
end