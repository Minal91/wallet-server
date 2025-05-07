class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :description
      t.integer :sender_id
      t.integer :receiver_id
      t.string :type

      t.timestamps
    end
  end
end
