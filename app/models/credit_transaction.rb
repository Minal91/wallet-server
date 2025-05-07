class CreditTransaction < Transaction
  # Additional logic for credit transactions can go here
  after_commit :update_balance, on: :create

  def update_balance
    # Update the user's balance after a credit transaction
    user.balance.increment!(:total_credits, amount)
    user.balance.increment!(:current_balance, amount)
  end
end