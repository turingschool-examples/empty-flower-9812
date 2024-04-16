class RemoveRideIdFromMechanics < ActiveRecord::Migration[7.1]
  def change
    remove_column :mechanics, :ride_id, :bigint
  end
end
