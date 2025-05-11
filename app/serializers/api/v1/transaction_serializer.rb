class TransactionSerializer < ActiveModel::Serializer
  attributes :amount, :type, :created_at, :updated_at
  attribute :id, key: :transaction_id

  def amount
    object.amount.to_f
  end

  def transaction_type
    object.transaction_type.humanize
  end
end