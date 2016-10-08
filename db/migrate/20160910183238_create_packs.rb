class CreatePacks < ActiveRecord::Migration[5.0]
  def change
    create_table :packs, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
