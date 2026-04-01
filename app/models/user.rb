class User < ApplicationRecord
  has_many :messages
  has_many :rooms

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_secure_token :api_token

  validates :username, presence: true, uniqueness: true

  enum :role, {
    user: 0,
    admin: 1
  }
end
