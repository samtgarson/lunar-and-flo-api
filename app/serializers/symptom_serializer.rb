class SymptomSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :group

  def group
    object.symptom_group.name
  end
end
