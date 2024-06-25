class CreateMakers < ActiveRecord::Migration[7.1]
  def change
    create_table :makers do |t|
      t.string :title
      t.string :origin
      t.string :homepage

      t.timestamps
    end

    add_reference :items, :maker, index: true
  end
end
