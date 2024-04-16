class Mechanic < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides
  has_many :rides
  has_many :rides, through: :mechanic_rides
end
