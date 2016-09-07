class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :lat
      t.string :lng
      t.references :locatable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end
  end
end
