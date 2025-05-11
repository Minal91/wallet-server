class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :created_at, :updated_at
  attribute :id, key: :user_id

  def created_at
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def updated_at
    object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end