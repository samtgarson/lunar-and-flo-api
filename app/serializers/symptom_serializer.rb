class SymptomSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :group, :points

  def group
    object.symptom_group.name
  end
end
