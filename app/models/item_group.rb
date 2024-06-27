class ItemGroup < ApplicationRecord
  has_many :joiners, dependent: :destroy
  has_many :items, through: :joiners

  validates :title, presence: true
end
