class AddLinkToItemGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :item_groups, :link, :string
  end
end
