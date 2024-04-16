class Mechanic < ApplicationRecord
  belongs_to :ride
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides
end
