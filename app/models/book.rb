class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #この本をいいね舌ユーザーの配列 iranakatta
  #has_many :favorites_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(keyword, matching)
    case matching
      when "forward" then
        where(["title like ?", "#{keyword}%"])
      when "backward" then
        where(["title like ?", "%#{keyword}"])
      when "exact" then
        where(["title like ?", "#{keyword}"])
      when "partial" then
        where(["title like ?", "%#{keyword}%"])
    end
  end

end
