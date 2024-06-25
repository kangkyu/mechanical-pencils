class Progressor < ApplicationRecord
  belongs_to :item_group
  belongs_to :user
end
