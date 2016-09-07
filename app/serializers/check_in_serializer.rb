class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :location

  has_many :symptoms
end
