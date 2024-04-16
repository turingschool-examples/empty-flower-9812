require 'rails_helper'

RSpec.describe "Mechanics Show Page" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @mechanic1 = Mechanic.create!(name: "Larry", years_experience: 3)
    @mechanic2 = Mechanic.create!(name: "Ben", years_experience: 10)

    @ride1 = @mechanic1.rides.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: @amusement_park.id)
    @ride2 = @mechanic1.rides.create!(name: "Dragon Hunter", thrill_rating: 6, open: false, amusement_park_id: @amusement_park.id)
    @ride3 = @mechanic2.rides.create!(name: "Twister", thrill_rating: 9, open: false, amusement_park_id: @amusement_park.id)
    @ride4 = @mechanic2.rides.create!(name: "Merchant of Death", thrill_rating: 10, open: false, amusement_park_id: @amusement_park.id)
  end

  describe 'User Story 1' do
    it "Displays a mechanics attributes" do
      visit mechanic_path(@mechanic1)

      expect(page).to have_content(@mechanic1.name)
      expect(page).to have_content(@mechanic1.years_experience)

      expect(page).to_not have_content(@mechanic2.name)
      expect(page).to_not have_content(@mechanic2.years_experience)
    end

    it "Displays a mechanics rides name" do
      visit mechanic_path(@mechanic1)

      expect(page).to have_content(@ride1.name)
      expect(page).to have_content(@ride2.name)

      expect(page).to_not have_content(@ride3.name)
      expect(page).to_not have_content(@ride4.name)
    end
  end
end