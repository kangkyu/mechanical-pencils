class CreateThreadsAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :threads_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.json :tokens, default: {}
      t.string :threads_user_id

      t.timestamps
    end
  end
end
