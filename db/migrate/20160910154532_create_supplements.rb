class CreateSupplements < ActiveRecord::Migration[5.0]
  def change
    create_table :supplements, id: :uuid do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :supplement_symptoms, id: :uuid do |t|
      t.references :supplement, type: :uuid, foreign_key: true
      t.references :symptom, type: :uuid, foreign_key: true
    end

    add_index :supplement_symptoms, [:supplement_id, :symptom_id], unique: true
    add_index :check_in_symptoms, [:check_in_id, :symptom_id], unique: true
  end
end
