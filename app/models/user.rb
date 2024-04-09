class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :ownerships
  has_many :items, through: :ownerships
end
