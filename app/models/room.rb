class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  after_destroy_commit -> { broadcast_remove_to "rooms" }
end
