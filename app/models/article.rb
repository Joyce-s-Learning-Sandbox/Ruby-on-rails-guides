class Article < ApplicationRecord
  has_many :comments, dependent: :destroy 
  # If you delete an article, its associated comments will also need to be deleted, otherwise they would simply occupy space in the database.
  # if you have an instance variable @article containing an article, you can retrieve all the comments belonging to that article as an array using @article.comments.
  validates :title, presence: true, length: {minimum: 5}
end
