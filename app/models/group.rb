class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true

  def join?(user)
    GroupUser.where(user_id: user.id, group_id: id).exists?
  end

  def owner
    User.find(owner_id)
  end

end
