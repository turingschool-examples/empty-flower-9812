require "rails_helper"

RSpec.describe "mechanics show page" do

  # User Story 1
  it 'lists name, years of experience, and names of rides currently being worked on' do
    # Setup
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @dave = Mechanic.create!(name: "Dave Williams", years_experience: 30)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @dave.id)


    # As a user, when I visit a mechanic show page
    visit "/mechanics/#{@dave.id}"

    # I see their name, years of experience, and the names of all rides they are working on.
    within "mechanic_info" do
      expect(page).to have_content("#{@dave.name}")
      expect(page).to have_content("#{@dave.years_experience}")
    end

    # Add Rides currently being worked on
  end

end