class Mechanic < ApplicationRecord
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides


  def add_ride(ride_id)
    ride = Ride.find(ride_id)
    self.rides << ride
  end
end