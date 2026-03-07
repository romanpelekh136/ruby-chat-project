class Room < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
end
