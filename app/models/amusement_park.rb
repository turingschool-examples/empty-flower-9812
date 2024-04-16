class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def unique_list_of_mechanics
    self.mechanics.distinct
  end
end