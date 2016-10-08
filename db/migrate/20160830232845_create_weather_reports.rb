class CreateWeatherReports < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_reports, id: :uuid do |t|
      t.string :icon
      t.float :cloud_cover
      t.float :temperature
      t.float :precip_probability
      t.string :precip_type
      t.float :moon_phase

      t.timestamps
    end
  end
end
