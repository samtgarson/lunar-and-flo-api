class Forest::Symptom
  include ForestLiana::Collection

  collection :symptoms

  field :group, type: 'String' do
    object.symptom_group.try(:name)
  end
end
