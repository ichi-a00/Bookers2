class Room < ApplicationRecord
  #DM昨日
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
end
