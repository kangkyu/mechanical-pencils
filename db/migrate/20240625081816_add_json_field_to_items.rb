class AddJsonFieldToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :data, :json, default: {}
    add_column :items, :description, :text
    add_column :items, :model_number, :string
  end
end
