require "rails_helper"

RSpec.describe "Mechanics show spec" do
  before(:each) do
    @park1 = AmusementPark.create!(name: "Denver", admission_cost: 33)
    @ride1 = @park1.rides.create!(name: "Tower", thrill_rating: 8, open: true)
    @ride2 = @park1.rides.create!(name: "Doom", thrill_rating: 8, open: false)
    @ride3 = @park1.rides.create!(name: "Merry-go-round", thrill_rating: 3, open: true)
    @mechanic1 = @ride1.mechanics.create!(name: "Martin", years_experience: 10)
    @mechanic2 = @ride1.mechanics.create!(name: "Rodrigo", years_experience: 9)

    MechanicRide.create!(ride_id: @ride2.id, mechanic_id: @mechanic1.id)
  end

  describe '#us 1' do
    it 'Displays a mechacnics attributes and what rides they are working on' do

      # When I visit a mechanic show page
      visit "/mechanic/#{@mechanic1.id}"
      # save_and_open_page
      # I see their name, years of experience, and the names of all rides they are working on.
      expect(page).to have_content("Name: Martin")
      expect(page).to have_content("Experience: 10")
      expect(page).to have_content("Tower")
      expect(page).to have_content("Doom")

    end
  end

  describe '#us 2' do
   it 'has a button to update' do


    # When I go to a mechanic's show page
    visit "/mechanic/#{@mechanic1.id}"
    # I see a form to add a ride to their workload


    expect(page).to have_link("Add Ride")
    click_on("Add Ride")
    # When I fill in that field with an id of an existing ride and click Submit
    fill_in :ride_id, with: @ride3.id
    click_on("Submit")
    # I’m taken back to that mechanic's show page
    expect(current_path).to eq("/mechanic/#{@mechanic1.id}")
    # And I see the name of that newly added ride on this mechanic's show page.
    expect(page).to have_content("Merry-go-round")


   end
 end
end