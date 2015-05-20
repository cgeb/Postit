class User < ActiveRecord::Base
  include SluggableCgeb
  
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :user_name, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 5}, on: :create

  sluggable_column :user_name

  def admin?
    self.role == 'admin'
  end
end