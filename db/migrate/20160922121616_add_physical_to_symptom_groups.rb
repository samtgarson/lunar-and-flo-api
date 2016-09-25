class AddPhysicalToSymptomGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :symptom_groups, :physical, :boolean, default: false
  end
end
