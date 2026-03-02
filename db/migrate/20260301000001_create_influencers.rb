class CreateInfluencers < ActiveRecord::Migration[8.1]
  def change
    create_table :influencers do |t|
      t.string :name, null: false
      t.text :bio
      t.string :platform
      t.string :handle
      t.string :profile_url
      t.integer :follower_count

      t.timestamps
    end
  end
end
