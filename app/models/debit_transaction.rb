class DebitTransaction < Transaction
  # Additional logic for debit transactions can go here

  def update_balance
    # Update the user's balance after a credit transaction
    user.balance.increment!(:total_credits, amount)
    user.balance.increment!(:current_balance, amount)
  end
   
end