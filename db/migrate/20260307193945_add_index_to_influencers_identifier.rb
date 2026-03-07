class AddIndexToInfluencersIdentifier < ActiveRecord::Migration[8.1]
  def change
    add_index :influencers, :identifier, unique: true
  end
end
