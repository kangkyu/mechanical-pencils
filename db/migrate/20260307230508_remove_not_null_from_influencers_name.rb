class RemoveNotNullFromInfluencersName < ActiveRecord::Migration[8.1]
  def change
    change_column_null :influencers, :name, true
  end
end
