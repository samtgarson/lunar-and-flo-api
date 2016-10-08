class EffectSerializer < ActiveModel::Serializer
  attributes :effectiveness_days

  belongs_to :supplement
  belongs_to :symptom
end
