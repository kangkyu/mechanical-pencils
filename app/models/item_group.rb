class ItemGroup < ApplicationRecord
  has_many :joiners, dependent: :destroy
  has_many :items, through: :joiners
end
