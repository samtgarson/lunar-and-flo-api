class SupplementSerializer < ActiveModel::Serializer
  attributes :id, :description, :name

  has_many :symptoms
end
