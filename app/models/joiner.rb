class Joiner < ApplicationRecord
  belongs_to :item_group
  belongs_to :item
end
