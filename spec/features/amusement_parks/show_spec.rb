require "rails_helper"

RSpec.describe "amusement parks show page" do

  # User Story 3
  it 'lists the name, price of admission, and unique mechanics working on the parks rides' do
    # Setup
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @dave = Mechanic.create!(name: "Dave Williams", years_experience: 30)
    @barbara = Mechanic.create!(name: "Barbara Jones", years_experience: 15)
    @kyle = Mechanic.create!(name: "Kyle Smith", years_experience: 22)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @dave.id)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @barbara.id)
    MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @barbara.id)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @kyle.id)

    # As a visitor, when I visit an amusement park’s show page,
    visit "/amusement_parks/#{@six_flags.id}"

    # Then I see the name and price of admissions for that amusement park
    within ".park_info" do
      expect(page).to have_content("#{@six_flags.name}")
      expect(page).to have_content("#{@six_flags.admission_cost}")
    end

    # And I see the names of all mechanics that are working on that park's rides,
    within ".park_mechanics" do
      # And I see that the list of mechanics is unique
      expect(page).to have_content("#{@dave.name}", count: 1)
      expect(page).to have_content("#{@barbara.name}", count: 1)
      expect(page).to have_content("#{@kyle.name}", count: 1)
    end
  end

end