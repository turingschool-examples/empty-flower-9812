class AmusementPark < ApplicationRecord
  has_many :rides

  def unique_mechanic_names
    self.rides.joins(:mechanics).distinct.pluck("mechanics.name")
  end
end