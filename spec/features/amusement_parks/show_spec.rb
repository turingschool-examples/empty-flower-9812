require 'rails_helper'

RSpec.describe "Amusement Parks Show Page" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @mechanic1 = Mechanic.create!(name: "Larry", years_experience: 3)
    @mechanic2 = Mechanic.create!(name: "Ben", years_experience: 10)

    @ride1 = @mechanic1.rides.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: @amusement_park.id)
    @ride2 = @mechanic1.rides.create!(name: "Dragon Hunter", thrill_rating: 6, open: false, amusement_park_id: @amusement_park.id)
    @ride3 = @mechanic2.rides.create!(name: "Twister", thrill_rating: 9, open: false, amusement_park_id: @amusement_park.id)
    @ride4 = @mechanic2.rides.create!(name: "Merchant of Death", thrill_rating: 10, open: false, amusement_park_id: @amusement_park.id)
    @ride5 = Ride.create!(name: "Fun Time", thrill_rating: 2, open: false, amusement_park_id: @amusement_park.id)
  end

  describe 'User Story 3' do
    it "displays the parks name and admision fee" do
      visit amusement_park_path(@amusement_park)

      expect(page).to have_content(@amusement_park.name)
      expect(page).to have_content(@amusement_park.admission_cost)
    end

    it "displays the parks mechanics" do
      visit amusement_park_path(@amusement_park)

      expect(page).to have_content(@mechanic1.name)
      expect(page).to have_content(@mechanic2.name)
    end
  end
end