class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :ownerships
  has_many :items, through: :ownerships

  def owned(item)
    items.exists? item.id
  end
end
