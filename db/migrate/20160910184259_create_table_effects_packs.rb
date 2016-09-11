class CreateTableEffectsPacks < ActiveRecord::Migration[5.0]
  def change
    create_table :effects_packs, id: :uuid do |t|
      t.references :effect, foreign_key: true, type: :uuid, index: true
      t.references :pack, foreign_key: true, type: :uuid, index: true
      t.index [:pack_id, :effect_id]

      t.timestamps
    end
  end
end
