class CreateSymptomGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :symptom_groups, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
