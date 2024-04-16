require "rails_helper"

RSpec.describe "Mechanics Show Page", type: :feature do
  before :each do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @jb = Mechanic.create!(name: 'Jim Bean', years_experience: 45)
    @jane = Mechanic.create!(name: 'Jane Doe', years_experience: 20)
    @bt = Mechanic.create!(name: 'Billy Turner', years_experience: 6)

    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @jb.id)
    MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @kara.id)
    MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @jb.id)
    MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @jane.id)
    MechanicRide.create!(ride_id: @jaws.id, mechanic_id: @bt.id)
    MechanicRide.create!(ride_id: @jaws.id, mechanic_id: @jb.id)
  end

  describe "User Story 1" do
    it "shows name, years of experience, and the names of all rides they are working on" do
      visit "/mechanics/#{@jb.id}"

      expect(page).to have_content("#{@jb.name}")
      expect(page).to have_content("#{@jb.years_experience}")
      expect(page).to have_content("#{@hurler.name}")
      expect(page).to have_content("#{@jaws.name}")
    end
  end

  describe "User Story 2" do
    it "displays a form to add a ride to the mechanic's page with given id" do
      visit "/mechanics/#{@bt.id}"

      expect(page).to have_field(:ride_id)
      expect(page).to have_button("Add Ride")
    end

    it "should allow user to add a ride via the form on the show page" do
      visit "/mechanics/#{@bt.id}"

      expect(page).to_not have_content(@hurler.name)

      fill_in :ride_id, with: @hurler.id
      click_button "Add Ride"

      expect(current_path).to eq("/mechanics/#{@bt.id}")
      expect(page).to have_content(@hurler.name)
    end
  end
end