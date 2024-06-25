class MigrateManufacturers < ActiveRecord::Migration[7.1]
  def up
    maker_missing = Maker.find_or_create_by(title: "N")
    Item.find_each do |item|
      if item.maker.present?
        item.item_maker = Maker.find_or_create_by(title: item.maker)
      else
        item.item_maker = maker_missing
      end
      item.save
    end
  end

  def down
    # cannot make item_maker back to nil (validation fail)
  end
end
