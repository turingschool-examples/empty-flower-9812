class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics

  def unique_name
    mechanics.distinct.pluck(:name)
  end
end