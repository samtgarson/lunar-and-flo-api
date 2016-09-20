class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :device_id
end
