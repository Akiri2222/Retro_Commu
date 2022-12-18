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

  #タグ付け
  def save_tags(tags)
    tags.each do |new_tags|
      tag = Tag.find_or_create_by(name: new_tags)
      self.post_tags.find_or_create_by(tag_id: tag.id)
    end
  end

  #タグ更新
  def update_tags(latest_tags)
    tags = Tag.all
    post_tags = PostTag.all
    current_tags = self.tags
    current_tags_name = current_tags.pluck(:name)
    if self.tags.empty?
      save_tags(latest_tags)
    else
      all_tags = (current_tags_name + latest_tags).uniq.compact
      delete_tags = all_tags.reject{ |tag| latest_tags.include?(tag) }
      add_tags = all_tags.reject{ |tag| current_tags_name.include?(tag) }
      shared_tag_ids = Hash[*current_tags.map{|o| [o.id, o.post_tags.size]}.flatten].select{|k,v|v > 1}.keys
      delete_tags.each do |tag_name|
        tag = tags.find_by(name: tag_name)
        if shared_tag_ids.include?(tag.id)
          post_tags.find_by(tag_id: tag.id, post_id: self.id)&.destroy
        else
          tag.destroy
        end
      end
      save_tags(add_tags)
    end
  end


end
