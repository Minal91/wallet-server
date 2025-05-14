class TransactionService
  def initialize(user)
    @user = user
  end

  def create_credit_transaction(amount:, description:)
    transaction = CreditTransaction.new(user: @user, amount: amount, description: description)
    if transaction.save
      { success: true, transaction: transaction }
    else
      { success: false, errors: transaction.errors.full_messages }
    end
  end

  def create_debit_transaction(amount:, description:)
    transaction = DebitTransaction.new(user: @user, amount: amount, description: description)
    if transaction.save
      { success: true, transaction: transaction }
    else
      { success: false, errors: transaction.errors.full_messages }
    end
  end

  def create_transfer_transaction(amount:, description:, receiver:)
    transaction = TransferTransaction.new(sender: @user, receiver: receiver, amount: amount, description: description)
    if transaction.save
      { success: true, transaction: transaction }
    else
      { success: false, errors: transaction.errors.full_messages }
    end
  end
end
