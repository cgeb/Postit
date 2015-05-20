class Comment < ActiveRecord::Base
  include VoteableCgeb
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  
  validates :body, presence: true
end