class EffectSerializer < ActiveModel::Serializer
  attributes :id, :effectiveness_days

  belongs_to :supplement
  belongs_to :symptom
end
