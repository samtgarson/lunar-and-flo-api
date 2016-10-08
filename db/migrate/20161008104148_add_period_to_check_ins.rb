class AddPeriodToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :period, :boolean
  end
end
