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

  #このユーザーがいいねした本の配列
  #has_many :favorites_books, through: :favorites, source: :book

  # user.followerはRelationshipのfollower_idを参照する
  has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  # user.followedはRelationshipのfollowed_idを参照する
  has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy

  #この記述もいる
  #user.followsで ユーザーがフォローしてる人一覧　ツイッターでいうフォロー一覧
  has_many :follows, through: :follower, source: :followed
  #user.followersがユーザーがフォローされてる人一覧　ツイッターでいうフォロワー一覧
  has_many :followers, through: :followed, source: :follower

  #DM昨日
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy

  #ex7c　グループ
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users


  attachment :profile_image

  def self.search(keyword, matching, user_id)
    case matching
      when "forward" then
        where(["name like ?", "#{keyword}%"])
      when "backward" then
        where(["name like ?", "%#{keyword}"])
      when "exact" then
        where(["name like ?", "#{keyword}"])
      when "partial" then
        where(["name like ?", "%#{keyword}%"])
    end
  end



end
