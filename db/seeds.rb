require "factory_bot"
require "faker"

include FactoryBot::Syntax::Methods

# Create users
user1 = create(:user)
user2 = create(:user)

# Create transactions
create(:credit_transaction, user: user1, amount: 2000, description: "Initial deposit")
create(:debit_transaction, user: user1, amount: 100, description: "Purchase")
# Currently user & sender are same but in future they can be different
create(:transfer_transaction, sender: user1, receiver: user2, user: user1, amount: 200, description: "Payment for services")

# Generate random transactions for testing
10.times do
  create(:credit_transaction, user: user1)
  create(:debit_transaction, user: user2)
  create(:transfer_transaction, sender: user1, receiver: user2, user: user1)
end