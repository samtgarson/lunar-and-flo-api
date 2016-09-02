class AddWeatherReportToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_reference :check_ins, :weather_report, foreign_key: true, type: :uuid
  end
end
