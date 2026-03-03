class Item < ApplicationRecord
  validates :title, presence: true

  has_many :ownerships, dependent: :destroy

  has_many :joiners, dependent: :destroy
  has_many :item_groups, through: :joiners

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  belongs_to :item_maker, class_name: "Maker", foreign_key: "maker_id"

  has_many :item_influencers, dependent: :destroy
  has_many :influencers, through: :item_influencers

  store_accessor :data, :category, :size, :color, :limited_edition
  store_accessor :data, :shop_url, :official_url

  scope :with_title, lambda { |title|
    where("lower(title) LIKE ?", "%#{title.downcase}%") if title.present?
  }

  def has_proof(user)
    ownerships.where(user_id: user).joins(:proof_attachment).exists?
  end

  def ownership_by_user(user)
    ownerships.where(user_id: user).joins(:proof_attachment).first
  end
end
