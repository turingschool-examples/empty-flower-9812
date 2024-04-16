class Mechanic < ApplicationRecord
  has_many :rides, through: :ride_mechanics
end
