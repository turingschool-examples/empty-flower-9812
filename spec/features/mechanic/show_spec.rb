require 'rails_helper'

RSpec.describe 'mechanic#show', type: :feature do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Park", admission_cost: 50)

    @mechanic = Mechanic.create!(name: 'John Doe', years_experience: 5)

    @ride1 = Ride.create!(name: 'Roller Coaster', thrill_rating: 8, open: true, amusement_park_id: @amusement_park.id)
    @ride2 = Ride.create!(name: 'Ferris Wheel', thrill_rating: 3, open: false, amusement_park_id: @amusement_park.id)
    @ride3 = Ride.create!(name: 'Tegris', thrill_rating: 3, open: false, amusement_park_id: @amusement_park.id)


    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride2.id)
  end

  # Story 1 - Mechanic Show Page
  it "mechanic attributes and the name of the rides" do
    # As a user,
    # When I visit a mechanic show page
    visit mechanic_path(@mechanic)
    # I see their name, years of experience, and the names of all rides they are working on.
    expect(page).to have_content(@mechanic.name)
    expect(page).to have_content(@mechanic.years_experience)

    within ".rides" do
      expect(page).to have_content("Rides they are working on:")
      expect(page).to have_content(@ride1.name)
      expect(page).to have_content(@ride2.name)
    end
  end

  # Story 2 - Add a Ride to a Mechanic
  it "can add a ride to a mechanic" do
    # As a user,
    # When I go to a mechanic's show page
    visit mechanic_path(@mechanic)
    # I see a form to add a ride to their workload
    expect(page).to have_content("Add Ride")
    expect(page).to_not have_content("Tegris")
    # When I fill in that field with an id of an existing ride and click Submit
    expect(page).to have_field(:ride_id)

    fill_in(:ride_id, with: @ride3.id)

    click_on("Submit")
    # I’m taken back to that mechanic's show page
    expect(current_path).to eq(mechanic_path(@mechanic))
    # And I see the name of that newly added ride on this mechanic's show page.
    expect(page).to have_content("Tegris")
  end
end