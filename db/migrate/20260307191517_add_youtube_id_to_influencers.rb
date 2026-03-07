class AddYoutubeIdToInfluencers < ActiveRecord::Migration[8.1]
  def change
    add_column :influencers, :identifier, :string
  end
end
