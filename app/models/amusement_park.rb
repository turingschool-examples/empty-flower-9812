class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :ride_mechanics, through: :rides
  has_many :mechanics, through: :ride_mechanics

  def unique_mechanics
    mechanics.distinct
  end

  def rides_by_avg_mechanic_experience
    rides.joins(:mechanics)
    .select("rides.*, AVG(mechanics.years_experience) AS average_experience")
    .group(:id)
    .order("average_experience DESC")
  end
end