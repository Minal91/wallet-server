class TransferTransaction < Transaction
  # Additional logic for transfer transactions can go here
  after_commit :update_balance, on: :create

  def update_balance
    # Update the sender's balance after a transfer transaction
    sender.balance.decrement!(:current_balance, amount)
    sender.balance.increment!(:total_debits, amount)

    # Update the receiver's balance after a transfer transaction
    receiver.balance.increment!(:current_balance, amount)
    receiver.balance.increment!(:total_credits, amount)
  end
end