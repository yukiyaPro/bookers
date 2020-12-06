class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image
  validates :name, length: { minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50 }
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
