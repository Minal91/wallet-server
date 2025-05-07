require "factory_bot"
require "faker"

include FactoryBot::Syntax::Methods

# Create users
user1 = create(:user)
user2 = create(:user)

# Create balances
create(:balance, user: user1, total_credits: 1000, total_debits: 0, current_balance: 1000)
create(:balance, user: user2, total_credits: 500, total_debits: 0, current_balance: 500)

# Create transactions
create(:credit_transaction, receiver: user1, amount: 200, description: "Initial deposit")
create(:debit_transaction, sender: user1, amount: 100, description: "Purchase")
create(:transfer_transaction, sender: user1, receiver: user2, amount: 200, description: "Payment for services")

# Generate random transactions for testing
10.times do
  create(:credit_transaction, receiver: user1)
  create(:debit_transaction, sender: user2)
  create(:transfer_transaction, sender: user1, receiver: user2)
end