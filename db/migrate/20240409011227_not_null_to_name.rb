class NotNullToName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :name, false
  end
end
