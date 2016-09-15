class PackSerializer < ActiveModel::Serializer
  attributes :id, :created_at

  has_many :effects
end
