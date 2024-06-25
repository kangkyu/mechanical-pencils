class CreateJoiners < ActiveRecord::Migration[7.1]
  def change
    create_table :joiners do |t|
      t.belongs_to :item_group, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
