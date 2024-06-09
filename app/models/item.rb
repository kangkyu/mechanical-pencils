class Item < ApplicationRecord
  validates :name, presence: true

  has_many :ownerships
  searchkick word_start: [:name]

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  def has_proof(user)
    ownerships.exists?(user_id: user) && ownerships.where(user_id: user).any? {|o| o.proof.attached? }
  end

  def ownership_by_user(user)
    ownerships.where(user_id: user).find {|o| o.proof.attached? }
  end

  def search_data
    {
      name: name
    }
  end
end
