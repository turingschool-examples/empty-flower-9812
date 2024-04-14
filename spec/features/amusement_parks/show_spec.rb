require "rails_helper"

RSpec.describe "the amusement parks show page" do
  before(:each) do
    @mechanic1 = Mechanic.create!(name: 'First Mechanic', years_experience: 10)
    @mechanic2 = Mechanic.create!(name: 'Second Mechanic', years_experience: 5)
    @mechanic3 = Mechanic.create!(name: 'Third Mechanic', years_experience: 19)
    @park1 = AmusementPark.create!(name: 'First Park', admission_cost: 100)
    @park2 = AmusementPark.create!(name: 'Second Park', admission_cost: 75)
    @ride1 = @park1.rides.create!(name: 'First Ride', thrill_rating: 5, open: true)
    @ride2 = @park1.rides.create!(name: 'Second Ride', thrill_rating: 3, open: false)
    @ride3 = @park1.rides.create!(name: 'Third Ride', thrill_rating: 10, open: true)
    @ride4 = @park2.rides.create!(name: 'Fourth Ride', thrill_rating: 99, open: false)
    @mechanic1.rides << @ride1 << @ride2
    @mechanic2.rides << @ride4
    @mechanic3.rides << @ride3
  end

  describe 'User Story 3' do
    it 'shows the amusement parks name and its price of admission and the name of all mechanics that are working on its rides and the mechancis list is unique' do
      visit amusement_park_path(@park1)

      expect(page).to have_content('First Park')
      expect(page).to have_content('Price of Admission: 100')

      expect(page).to_not have_content('Second Park')

      within '#park_mechanics' do
        expect(page).to have_content('First Mechanic', maximum: 1)
        expect(page).to have_content('Third Mechanic', maximum: 1)

        expect(page).to_not have_content('Second Mechanic')
      end
    end
  end
end