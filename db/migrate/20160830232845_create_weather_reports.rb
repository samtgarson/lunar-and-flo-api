class CreateWeatherReports < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_reports, id: :uuid do |t|
      t.string :weather
      t.float :cloud_cover
      t.float :temperature
      t.float :precip_probability
      t.string :precip_type

      t.timestamps
    end
  end
end
