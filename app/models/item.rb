class Item < ApplicationRecord
  validates :name, presence: true

  has_many :ownerships

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
