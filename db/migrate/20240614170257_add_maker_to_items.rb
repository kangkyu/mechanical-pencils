class AddMakerToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :maker, :string
  end
end
