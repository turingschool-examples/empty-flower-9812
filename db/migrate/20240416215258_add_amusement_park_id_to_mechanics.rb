class AddAmusementParkIdToMechanics < ActiveRecord::Migration[7.1]
  def change
    add_reference :mechanics, :amusement_park, null: false, foreign_key: true
  end
end
