class AddCategoryToSymptomGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :symptom_groups, :category, :integer, default: 0
  end
end
