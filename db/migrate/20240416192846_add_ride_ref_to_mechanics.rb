class AddRideRefToMechanics < ActiveRecord::Migration[7.1]
  def change
    add_reference :mechanics, :ride, null: false, foreign_key: true
  end
end
