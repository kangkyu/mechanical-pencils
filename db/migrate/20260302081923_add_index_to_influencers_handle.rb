class AddIndexToInfluencersHandle < ActiveRecord::Migration[8.1]
  def change
    add_index :influencers, :handle, unique: true, where: "handle IS NOT NULL"
  end
end
