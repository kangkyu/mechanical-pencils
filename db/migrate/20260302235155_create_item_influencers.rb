class CreateItemInfluencers < ActiveRecord::Migration[8.1]
  def change
    create_table :item_influencers do |t|
      t.references :item, null: false, foreign_key: true
      t.references :influencer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :item_influencers, [:item_id, :influencer_id], unique: true

    # Migrate existing data
    reversible do |dir|
      dir.up do
        execute <<~SQL
          INSERT INTO item_influencers (item_id, influencer_id, created_at, updated_at)
          SELECT id, influencer_id, NOW(), NOW()
          FROM items
          WHERE influencer_id IS NOT NULL
        SQL
      end
    end

    remove_reference :items, :influencer, foreign_key: true
  end
end
