require "rails_helper"

RSpec.describe "Mechanics show spec" do
  before(:each) do
    @park1 = AmusementPark.create!(name: "Denver", admission_cost: 33)
    @ride1 = @park1.rides.create!(name: "Tower", thrill_rating: 8, open: true)
    @ride2 = @park1.rides.create!(name: "Doom", thrill_rating: 8, open: false)
    @mechanic1 = @ride1.mechanics.create!(name: "Martin", years_experience: 10)
    @mechanic2 = @ride1.mechacnics.create!(name: "Rodrigo", years_experience: 9)

    @ride_mechanic1 = MechanicRide.create(ride_id: 1, mechanic_id:)
  end

  describe '#us 1' do
    it 'Displays a mechacnics attributes and what rides they are working on' do

      # When I visit a mechanic show page
      visit "/mechanic/#{@mechanic1.id}"
      # save_and_open_page
      # I see their name, years of experience, and the names of all rides they are working on.
      expect(page).to have_content("Name: Martin")
      expect(page).to have_content("Experience: 10")

    end
  end
end