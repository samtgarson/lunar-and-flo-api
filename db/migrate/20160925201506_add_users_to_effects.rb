class AddUsersToEffects < ActiveRecord::Migration[5.0]
  def change
    add_reference :effects, :user, foreign_key: true, type: :uuid
  end
end
