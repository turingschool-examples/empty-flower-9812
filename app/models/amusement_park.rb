class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def mechanics_list
    mechanics.distinct
  end
end
