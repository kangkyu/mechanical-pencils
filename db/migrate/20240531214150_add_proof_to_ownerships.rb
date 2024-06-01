class AddProofToOwnerships < ActiveRecord::Migration[7.1]
  def change
    add_column :ownerships, :proof, :string
  end
end
