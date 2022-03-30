class Post < ApplicationRecord
  belongs_to :customer
  has_many :comments, dependent: :destroy  #Post.commentsで、投稿が所有するコメントw取得できる。
end
