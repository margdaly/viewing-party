class User < ApplicationRecord
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties

  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, uniqueness: true, presence: true

  has_secure_password
end
