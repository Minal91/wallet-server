class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :description
      t.integer :sender_id, null: true
      t.integer :receiver_id, null: true
      t.string :type
      t.references :user, index: true

      t.timestamps
    end
  end
end
