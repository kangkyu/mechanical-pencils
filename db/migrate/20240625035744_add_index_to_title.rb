class AddIndexToTitle < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    add_index :items, :title, algorithm: :concurrently
  end

  def down
    remove_index :items, :title, algorithm: :concurrently
  end
end
