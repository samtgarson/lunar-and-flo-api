class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins, id: :uuid do |t|
      t.references :symptom, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
