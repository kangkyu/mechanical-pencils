class RemoveProgressors < ActiveRecord::Migration[7.1]
  def change
    drop_table :progressors, if_exists: true
  end
end
