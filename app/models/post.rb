class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags

  validates :title, presence: true
  validates :text, presence: true

  #ブックマーク済みかどうか判定する
  def book_marked_by?(user)
    book_marks.exists?(user_id: user.id)
  end

  #部分検索
  def self.search_for(content, method)
    Post.where('title LIKE ?', '%'+content+'%')
  end



end
