class DropLocation < ActiveRecord::Migration[5.0]
  def change
    drop_table :locations, id: :uuid do |t|
      t.float :lat
      t.float :lng
      t.references :locatable, type: :uuid, polymorphic: true, index: true

      t.timestamps
    end

    add_column :weather_reports, :lat, :float
    add_column :weather_reports, :lng, :float

    add_column :check_ins, :lat, :float
    add_column :check_ins, :lng, :float
  end
end
