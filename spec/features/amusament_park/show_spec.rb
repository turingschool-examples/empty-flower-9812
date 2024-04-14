require 'rails_helper'

RSpec.describe 'amusement_park#show', type: :feature do
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

  # Story 3 - Amusement Park Show page
  it "unique list" do
    # As a visitor,
    # When I visit an amusement park’s show page,
    visit amusement_park_path(@amusement_park_1)
    # Then I see the name and price of admissions for that amusement park
    expect(page).to have_content(@amusement_park_1.name)
    expect(page).to_not have_content(@amusement_park_2.name)
    expect(page).to have_content("$50")
    expect(page).to_not have_content("$100")
    within '.Mechanics_name_list' do
      # And I see the names of all mechanics that are working on that park's rides,
      expect(page).to have_content("Mechanics Working on Rides:")
      # And I see that the list of mechanics is unique
      expect(page).to have_content("John Doe")
      expect(page).to have_content("Luis")
      expect(page).to_not have_content("Juan")
    end
  end
end