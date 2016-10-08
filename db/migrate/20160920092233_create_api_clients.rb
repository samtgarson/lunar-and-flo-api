class CreateApiClients < ActiveRecord::Migration[5.0]
  def change
    create_table :api_clients, id: :uuid do |t|
      t.string :secret_key
      t.string :name

      t.timestamps
    end
  end
end
