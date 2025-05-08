class Balance < ApplicationRecord
  belongs_to :user

  def credit(amount)
    self.current_balance += amount
    self.total_credits += amount
    save!
  end

  def debit(amount)
    if self.current_balance >= amount
      self.current_balance -= amount
      self.total_debits += amount
      save!
    else
      errors.add(:base, "Insufficient balance")
      false
    end
  end
end
