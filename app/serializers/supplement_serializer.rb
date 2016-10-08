class SupplementSerializer < ActiveModel::Serializer
  attributes :id, :description, :name

  has_many :effects
end
