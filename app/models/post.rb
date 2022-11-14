class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy


  #ブックマーク済みかどうか判定する
  def book_marked_by?(user)
    book_marks.exists?(user_id: user.id)
  end


end
