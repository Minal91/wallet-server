class Transaction < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', optional: true
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id', optional: true
    belongs_to :user
    validates :amount, numericality: { greater_than: 0 }
    validates :description, presence: true

    before_save :update_balances
end
