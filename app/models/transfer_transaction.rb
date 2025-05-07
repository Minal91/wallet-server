class TransferTransaction < Transaction
  # Additional logic for transfer transactions can go here

  def update_balances
    # Update the sender's balance after a transfer transaction
    ActiveRecord::Base.transaction do
      user.balance.debit(amount)
      receiver.balance.credit(amount)
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle the error if the balance update fails  
    Rails.logger.error("Failed to update balance for user #{user.id}: #{e.message}")
    # Optionally, you can raise the error again or handle it as needed
  end
end