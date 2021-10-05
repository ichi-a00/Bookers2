class Message < ApplicationRecord
  #140時
  validates :message, presence: true, length: {maximum:140}
  belongs_to :user
  belongs_to :room
end
