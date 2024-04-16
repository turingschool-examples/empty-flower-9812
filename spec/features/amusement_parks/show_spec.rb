require 'rails_helper'

RSpec.describe 'Amusement Park show' do
  before :each do
      @park1 = AmusementPark.create!(name: "Funtime", admission_cost: 1)

      @ride1 = @park1.rides.create!(name: "Gravitron", thrill_rating: 9, open: true)
      @ride2 = @park1.rides.create!(name: "Chill", thrill_rating: 1, open: true)
      @ride3 = @park1.rides.create!(name: "Wow", thrill_rating: 15, open: true)

      @mech1 = @park1.mechanics.create!(name: "Nico", years_experience: 1)
      @mech2 = @park1.mechanics.create!(name: "Wolf", years_experience: 2)
      @mech3 = @park1.mechanics.create!(name: "Wolf", years_experience: 2)
  
      @mech1_ride1 = MechanicRide.create!(mechanic_id: @mech1.id, ride_id: @ride1.id)
      @mech1_ride2 = MechanicRide.create!(mechanic_id: @mech1.id, ride_id: @ride2.id)
      @mech2_ride1 = MechanicRide.create!(mechanic_id: @mech2.id, ride_id: @ride1.id)
      @mech2_ride2 = MechanicRide.create!(mechanic_id: @mech2.id, ride_id: @ride3.id)
    end
  describe 'US3' do
    it 'displays the name and admission price, a list of all unique mechanics of a park' do
      # As a visitor,
      # When I visit an amusement park’s show page,
      visit amusement_park_path(@park1)
      # Then I see the name and price of admissions for that amusement park
      expect(page).to have_content(@park1.name)
      expect(page).to have_content("Admission cost: #{@park1.admission_cost}")
      # And I see the names of all mechanics that are working on that park's rides,
      # And I see that the list of mechanics is unique
      within '.mechanics' do
        expect(page).to have_content(@mech1.name, count: 1)
        expect(page).to have_content(@mech2.name, count: 1)
      end
    end
  end
end