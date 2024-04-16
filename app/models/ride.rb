class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanics, through: :ride_mechanics
end
