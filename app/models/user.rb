class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # user.follower は userがフォローしてる人一覧　フォロー
  has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy

  # user.followed は userをフォローしてる人一覧　フォロワー
  has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy


  attachment :profile_image


end
