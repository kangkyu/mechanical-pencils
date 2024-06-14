class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :ownerships, dependent: :destroy
  has_many :items, through: :ownerships

  def owned(item)
    ownerships.exists? item_id: item
  end

  def admin?
    true
  end
end
