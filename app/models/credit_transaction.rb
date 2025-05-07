class CreditTransaction < Transaction
  # Additional logic for credit transactions can go here

  def update_balances
    # Update the user's balance after a credit transaction
    ActiveRecord::Base.transaction do
      user.balance.credit(amount)
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle the error if the balance update fails    
    Rails.logger.error("Failed to update balance for user #{user.id}: #{e.message}")
    # Optionally, you can raise the error again or handle it as needed
  end
end