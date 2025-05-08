class TransferTransaction < Transaction
  # Additional logic for transfer transactions can go here


  validate :sufficient_balance

  def sufficient_balance
    if user.balance.current_balance.to_f < amount.to_f
      errors.add(:base, "Insufficient balance to complete the transaction")
    end
  end

  def update_balances
    # Update the sender's balance after a transfer transaction
    ActiveRecord::Base.transaction do
      if user.balance.debit(amount) 
        receiver.balance.credit(amount) 
      else
        # Handle the case where the sender's balance is insufficient
        errors.add(:base, user.balance.errors.full_messages)
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle the error if the balance update fails  
    Rails.logger.error("Failed to update balance for user #{user.id}: #{e.message}")
    # Optionally, you can raise the error again or handle it as needed
  end
end