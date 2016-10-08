class AddIconToSymptomGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :symptom_groups, :icon, :integer
  end
end
