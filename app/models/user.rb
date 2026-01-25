class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :ownerships, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :items, through: :ownerships
  has_many :item_groups, through: :items

  has_many :threads_accounts, dependent: :destroy
  has_many :api_tokens, dependent: :destroy

  def owned(item)
    ownerships.exists? item_id: item
  end

  def admin?
    email == "admin@lininglink.com"
  end
end
