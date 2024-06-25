class ItemGroup < ApplicationRecord
  # has_many :progressors, dependent: :destroy
  # has_many :users, through: :progressors

  has_many :joiners, dependent: :destroy
  has_many :items, through: :joiners
end
