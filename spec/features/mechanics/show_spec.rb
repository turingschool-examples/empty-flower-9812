require "rails_helper"

RSpec.describe "the mechanics show page" do
  before(:each) do
    @mechanic1 = Mechanic.create!(name: 'First Mechanic', years_experience: 10)
    @mechanic2 = Mechanic.create!(name: 'Second Mechanic', years_experience: 5)
    @amusement_park1 = AmusementPark.create!(name: 'First Park', admission_cost: 100)
    @ride1 = @amusement_park1.rides.create!(name: 'First Ride', thrill_rating: 5, open: true)
    @ride2 = @amusement_park1.rides.create!(name: 'Second Ride', thrill_rating: 3, open: false)
    @ride3 = @amusement_park1.rides.create!(name: 'Third Ride', thrill_rating: 10, open: true)
    @mechanic1.rides << @ride1 << @ride2
  end

  describe 'User Story 1' do
    it 'shows the mechanics name, years of experience and name of all rides they are working on' do
      visit mechanic_path(@mechanic1)

      expect(page).to have_content('First Mechanic')
      expect(page).to have_content('Years of Experience: 10')

      expect(page).to_not have_content('Second Mechanic')

      within '#mechanic_rides' do
        expect(page).to have_content('First Ride')
        expect(page).to have_content('Second Ride')

        expect(page).to_not have_content('Third Ride')
      end
    end
  end

  describe 'User Story 2' do
    it 'has a form to add a ride to a mechanics workload and when I fill out this form with a ride ID and click submit I am taken back to that mechanics show page and see the name of that new ride' do
      visit mechanic_path(@mechanic1)

      within '#mechanic_rides' do
        expect(page).to have_content('First Ride')
        expect(page).to have_content('Second Ride')

        expect(page).to_not have_content('Third Ride')
      end

      within '#add_ride_to_mechanic' do
        expect(page).to have_selector('form')
        expect(page).to have_field(:ride_id)

        fill_in(:ride_id, with: "#{@ride3.id}")
        click_button('Save')
      end

      expect(current_path).to eq(mechanic_path(@mechanic1))

      within '#mechanic_rides' do
        expect(page).to have_content('First Ride')
        expect(page).to have_content('Second Ride')
        expect(page).to have_content('Third Ride')
      end
    end
  end
end
