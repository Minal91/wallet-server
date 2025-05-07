FactoryBot.define do
    factory :balance do
      total_credits { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
      total_debits { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
      current_balance { total_credits - total_debits }
      association :user
    end
  end