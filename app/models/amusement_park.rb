class AmusementPark < ApplicationRecord
  has_many :rides
  
  # has_many :park_mechanics, through: :rides, class_name: 'Mechanic'
  # has_many :mechanics
end