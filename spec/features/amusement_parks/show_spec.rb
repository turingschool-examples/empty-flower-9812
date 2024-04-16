require 'rails_helper'

RSpec.describe 'Amusement Park Show Page' do
  before :each do
    @six_flags = AmusementPark.create!(id: 1, name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(id: 2, name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @john = Mechanic.create!(id: 1, name: 'John', years_experience: 5)
    @joe = Mechanic.create!(id: 2, name: 'Joe', years_experience: 8)

    @john.rides << @hurler
    @john.rides << @scrambler

    @joe.rides << @ferris
    @joe.rides << @jaws
  end

  describe 'User story 3' do
    it 'displays amusement parks admission price and name' do
      visit amusement_park_path(@six_flags)
save_and_open_page
      expect(page).to have_content("Name: Six Flags")
      expect(page).to have_content("Admission Price: $75")
    end

    it 'displays all mechanics at the amusement park' do
      visit amusement_park_path(@six_flags)

      expect(page).to have_content("John")
    end

    it 'displays a unique list of mechanics' do
      visit amusement_park_path(@six_flags)

      expect(page).to have_content("John Joe")
      expect(page).to_not have_content("John John Joe")
    end
  end
end