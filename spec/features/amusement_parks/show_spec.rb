require "rails_helper"

RSpec.describe "Amusment Park show page" do
  before(:each) do
    @park1 = AmusementPark.create!(name: "Denver", admission_cost: 33)
    @ride1 = @park1.rides.create!(name: "Tower", thrill_rating: 8, open: true)
    @ride2 = @park1.rides.create!(name: "Doom", thrill_rating: 8, open: false)
    @ride3 = @park1.rides.create!(name: "Merry-go-round", thrill_rating: 3, open: true)
    @mechanic1 = @ride1.mechanics.create!(name: "Martin", years_experience: 10)
    @mechanic2 = @ride1.mechanics.create!(name: "Rodrigo", years_experience: 9)
  end

  describe '#US 3' do
    it 'Shows all the mechanics that work in the amusment park' do
      # When I visit an amusement park’s show page,
      visit "/amusement_parks/#{@park1.id}"
      # Then I see the name and price of admissions for that amusement park
      expect(page).to have_content("Denver")
      expect(page).to have_content(33)
      # And I see the names of all mechanics that are working on that park's rides,
      expect(page).to have_content("Martin")
      expect(page).to have_content("Rodrigo")
      # And I see that the list of mechanics is unique

    end
  end
end