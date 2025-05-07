class CreateBalances < ActiveRecord::Migration[7.1]
  def change
    create_table :balances do |t|
      t.decimal :total_credits
      t.decimal :total_debits
      t.decimal :current_balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
