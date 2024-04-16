class CreateMechanicRides < ActiveRecord::Migration[7.1]
  def change
    create_table :mechanic_rides do |t|
      t.belongs_to :mechanic, null: false, foreign_key: true
      t.belongs_to :ride, null: false, foreign_key: true

      t.timestamps
    end
  end
end
