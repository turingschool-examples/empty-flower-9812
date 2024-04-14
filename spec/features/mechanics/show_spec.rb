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
    within ".mechanic_info" do
      expect(page).to have_content("#{@dave.name}")
      expect(page).to have_content("#{@dave.years_experience}")
    end

    # Add Rides currently being worked on
    within ".mechanic_rides" do
      expect(page).to have_content("#{@hurler.name}")
      expect(page).to have_content("#{@scrambler.name}")
      expect(page).to have_content("#{@ferris.name}")
    end
  end

  # User Story 2
  it 'can add a ride to a mechanic' do
    # Setup
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @megatron = @six_flags.rides.create!(name: 'Megatron', thrill_rating: 11, open: true)

    @dave = Mechanic.create!(name: "Dave Williams", years_experience: 30)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @dave.id)

    # As a user, when I go to a mechanic's show page
    visit "/mechanics/#{@dave.id}"

    # I see a form to add a ride to their workload
    within ".new_ride" do
      expect(page).to have_content("Add Ride by ID")
      expect(page).to have_button("Submit")
    end

    # When I fill in that field with an id of an existing ride and click Submit
    within ".new_ride" do
      fill_in :ride_id, with: "#{@megatron.id}"
      click_button "Submit"
    end
    
    # I’m taken back to that mechanic's show page
    expect(current_path).to eq("/mechanics/#{@dave.id}")

    # And I see the name of that newly added ride on this mechanic's show page.
    within ".mechanic_rides" do
      expect(page).to have_content("#{@megatron.name}")
    end
  end

end