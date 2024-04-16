require 'rails_helper'

RSpec.describe 'Mechanic Show page' do
  before :each do
    @park1 = AmusementPark.create!(name: "Funtime", admission_cost: 1)

    @ride1 = @park1.rides.create!(name: "Gravitron", thrill_rating: 9, open: true)
    @ride2 = @park1.rides.create!(name: "Chill", thrill_rating: 1, open: true)
    @ride3 = @park1.rides.create!(name: "Wow", thrill_rating: 15, open: true)

    @mech1 = Mechanic.create!(name: "Nico", years_experience: 1)
    @mech1_ride1 = MechanicRide.create!(mechanic_id: @mech1.id, ride_id: @ride1.id)
    @mech1_ride2 = MechanicRide.create!(mechanic_id: @mech1.id, ride_id: @ride2.id)
  end
  describe 'US1' do
    it 'displays a mechanics attributes and the rides that they work on' do
      # As a user,
      # When I visit a mechanic show page
      visit mechanic_path(@mech1)
      # I see their name, years of experience, and the names of all rides they are working on.
      expect(page).to have_content(@mech1.name)
      expect(page).to have_content("Years of experience: #{@mech1.years_experience}")
      within '.rides' do
        expect(page).to have_content("Ride name: #{@ride1.name}")
        expect(page).to have_content("Ride name: #{@ride2.name}")
      end
    end
  end

  describe "US2" do
    it 'has a form to add a ride to a mechanics workload' do
      # When I go to a mechanic's show page
      visit mechanic_path(@mech1)
      # I see a form to add a ride to their workload
      # When I fill in that field with an id of an existing ride and click Submit
      within '.addride' do
        fill_in 'Ride Id:', with: @ride3.id
        click_on 'Add ride'
      end
      # I’m taken back to that mechanic's show page
      expect(current_path).to eq(mechanic_path(@mech1))
      # And I see the name of that newly added ride on this mechanic's show page.
      within '.rides' do
        expect(page).to have_content("Ride name: #{@ride1.name}")
        expect(page).to have_content("Ride name: #{@ride2.name}")
        expect(page).to have_content("Ride name: #{@ride3.name}")
      end
    end
  end
end