class AddInfluencerToItems < ActiveRecord::Migration[8.1]
  def change
    add_reference :items, :influencer, null: true, foreign_key: true
  end
end
