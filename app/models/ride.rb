class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides
  has_many :mechanics, through: :mechanic_rides

  def mechanic_to_ride 
    mechanics.distinct.pluck(:name)
  end
end