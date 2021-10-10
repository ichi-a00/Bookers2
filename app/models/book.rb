class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #閲覧数
  is_impressionable counter_cache: true

  #この本をいいね舌ユーザーの配列 iranakatta
  #has_many :favorites_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(keyword, matching, user_id)
    case matching
      when "forward" then
        where(["title like ?", "#{keyword}%"])
      when "backward" then
        where(["title like ?", "%#{keyword}"])
      when "exact" then
        where(["title like ?", "#{keyword}"])
      when "partial" then
        where(["title like ?", "%#{keyword}%"])

      #ex9b
      when "day" then
        where(["created_at between ? and ? and user_id like ?", "#{keyword.in_time_zone.at_beginning_of_day}", "#{keyword.in_time_zone.at_end_of_day}", "#{user_id}"])

    end
  end

  def self.search_category(keyword, matching)
    case matching
      when "forward" then
        where(["category like ?", "#{keyword}%"])
      when "backward" then
        where(["category like ?", "%#{keyword}"])
      when "exact" then
        where(["category like ?", "#{keyword}"])
      when "partial" then
        where(["category like ?", "%#{keyword}%"])
    end
  end

end
