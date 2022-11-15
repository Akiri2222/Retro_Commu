class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy


  #ブックマーク済みかどうか判定する
  def book_marked_by?(user)
    book_marks.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end


end
