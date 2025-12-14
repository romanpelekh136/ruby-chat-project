class Room < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :name, presence: true
end
