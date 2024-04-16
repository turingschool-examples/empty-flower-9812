class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def uniq_mechs
    mechanics.distinct.pluck(:name)
  end
end