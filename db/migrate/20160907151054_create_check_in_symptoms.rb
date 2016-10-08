class CreateCheckInSymptoms < ActiveRecord::Migration[5.0]
  def change
    create_table :check_in_symptoms, id: :uuid do |t|
      t.references :check_in, foreign_key: true, type: :uuid
      t.references :symptom, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
