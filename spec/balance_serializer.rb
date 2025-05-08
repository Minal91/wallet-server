class BalanceSerializer < ActiveModel::Serializer
  attributes :balance, :currency, :created_at, :updated_at, :user_id
  attribute :id, key: :balance_id
  

  def balance
    object.balance.to_f
  end
end