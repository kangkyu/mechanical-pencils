class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :ownerships, -> { order(:created_at) }, dependent: :destroy
  has_many :items, through: :ownerships
  has_many :item_groups, through: :items

  # has_many :progressors, dependent: :destroy
  # has_many :item_groups, through: :progressors

  def owned(item)
    ownerships.exists? item_id: item
  end

  def admin?
    true
  end
end
