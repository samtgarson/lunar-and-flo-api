class RemoveSymptomIdFromCheckIns < ActiveRecord::Migration[5.0]
  def change
    remove_column :check_ins, :symptom_id
  end
end
