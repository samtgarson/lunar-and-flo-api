class AddPointsToSymptomGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :symptom_groups, :points, :integer, default: 0
  end
end
