class CreateSymptoms < ActiveRecord::Migration[5.0]
  def change
    create_table :symptoms, id: :uuid do |t|
      t.string :name
      t.string :description
      t.references :symptom_group, type: :uuid

      t.timestamps
    end
  end
end
