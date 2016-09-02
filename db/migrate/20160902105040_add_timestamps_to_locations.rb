class AddTimestampsToLocations < ActiveRecord::Migration[5.0]
  def change
    change_table :locations, &:timestamps
  end
end
