class RenameShopUrlToAmazonUrlInItemsData < ActiveRecord::Migration[8.1]
  def up
    Item.where("data->>'shop_url' IS NOT NULL").find_each do |item|
      raw = item.read_attribute(:data) || {}
      raw["amazon_url"] = raw.delete("shop_url")
      item.update_column(:data, raw.to_json)
    end
  end

  def down
    Item.where("data->>'amazon_url' IS NOT NULL").find_each do |item|
      raw = item.read_attribute(:data) || {}
      raw["shop_url"] = raw.delete("amazon_url")
      item.update_column(:data, raw.to_json)
    end
  end
end
