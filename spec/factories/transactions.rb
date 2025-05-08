FactoryBot.define do
    factory :transaction do
      amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
      description { Faker::Lorem.sentence }
      type { "CreditTransaction" } # Default type, can be overridden
      association :receiver, factory: :user
  
      factory :credit_transaction, class: "CreditTransaction" do
        type { "CreditTransaction" }
      end
  
      factory :debit_transaction, class: "DebitTransaction" do
        type { "DebitTransaction" }
      end
  
      factory :transfer_transaction, class: "TransferTransaction" do
        type { "TransferTransaction" }
        association :sender, factory: :user, strategy: :create
        association :receiver, factory: :user, strategy: :create
      end
    end
end