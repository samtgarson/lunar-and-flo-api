class SymptomSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :points, :icon, :group

  def group
    object.symptom_group.name
  end
end
