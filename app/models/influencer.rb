class Influencer < ApplicationRecord
  validates :name, presence: true
  validates :handle, uniqueness: true, allow_nil: true

  has_many :item_influencers, dependent: :destroy
  has_many :items, through: :item_influencers

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
