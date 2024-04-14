class CreateMechanicRides < ActiveRecord::Migration[7.1]
  def change
    create_table :mechanic_rides do |t|
      t.references :ride, null: false, foreign_key: true
      t.references :mechanic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
