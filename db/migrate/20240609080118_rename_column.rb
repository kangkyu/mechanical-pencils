class RenameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :name, :title
    remove_column :items, :image, 'string'
  end
end
