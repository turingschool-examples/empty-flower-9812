require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
  end

  before(:each) do
    @amusement_park_1 = AmusementPark.create!(name: "Park", admission_cost: 50)
    @amusement_park_2 = AmusementPark.create!(name: "Bush Gardens", admission_cost: 100)
    @amusement_park_3 = AmusementPark.create!(name: "Adventure Island", admission_cost: 80)

    @mechanic = Mechanic.create!(name: 'John Doe', years_experience: 5)
    @mechanic_2 = Mechanic.create!(name: 'Luis', years_experience: 6)
    @mechanic_3 = Mechanic.create!(name: 'Juan', years_experience: 10)

    @ride1 = Ride.create!(name: 'Roller Coaster', thrill_rating: 8, open: true, amusement_park_id: @amusement_park_1.id)
    @ride2 = Ride.create!(name: 'Ferris Wheel', thrill_rating: 3, open: false, amusement_park_id: @amusement_park_2.id)
    @ride3 = Ride.create!(name: 'Tegris', thrill_rating: 3, open: false, amusement_park_id: @amusement_park_3.id)


    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride1.id)

    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride2.id)
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_3.id, ride_id: @ride2.id)

    @mechanic_ride_5 = MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride3.id)
    @mechanic_ride_6 = MechanicRide.create!(mechanic_id: @mechanic_3.id, ride_id: @ride3.id)

  end
  describe "#unique_mechanic_names" do
    it "returns the unique names of mechanics associated with rides in the amusement park" do
      expect(@amusement_park_1.unique_mechanic_names).to_not eq([@mechanic.name, @mechanic_3.name])
      expect(@amusement_park_1.unique_mechanic_names).to eq([@mechanic.name, @mechanic_2.name])
    end
  end
end