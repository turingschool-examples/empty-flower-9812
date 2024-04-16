class AmusementPark < ApplicationRecord
  has_many :rides

  def mech_name
    self.rides
        .joins(:mechanics)
        .distinct
        .pluck('mechanics.name')
  end
end