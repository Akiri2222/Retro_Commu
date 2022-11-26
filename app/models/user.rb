class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  validates :name, presence: true
  validates :account_name, presence: true

  def self.search_for(content, method)
    User.where('name LIKE ?', '%' + content + '%')
  end

#ゲストログイン
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com', account_name: 'guestuser') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
