class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :balance, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :credit_transactions, class_name: 'CreditTransaction', dependent: :destroy
  has_many :debit_transactions, class_name: 'DebitTransaction', dependent: :destroy
  has_many :transfer_transactions, class_name: 'TransferTransaction', dependent: :destroy
  after_commit :create_balance, on: :create

  def create_balance  
    Balance.find_or_create_by(user_id: self.id) do |balance|
      balance.total_credits = 0
      balance.total_debits = 0
      balance.current_balance = 0
    end
  end
end
