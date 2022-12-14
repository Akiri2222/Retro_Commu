class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts,through: :post_tags
  validates :name, presence: true
  validates :name, uniqueness: true


end
