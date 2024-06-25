class CreateItemGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :item_groups do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
