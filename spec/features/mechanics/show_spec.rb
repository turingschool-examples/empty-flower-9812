require 'rails_helper'

RSpec.describe 'Mechanic Invoice Show Page' do
  before :each do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @john = Mechanic.create!(name: 'John', years_experience: 5)
    @joe = Mechanic.create!(name: 'Joe', years_experience: 8)

    @john.rides << @hurler
    @john.rides << @scrambler
    @joe.rides << @ferris
    @joe.rides << @jaws
  end

  describe 'User story 1' do
    it 'shows a mechanics name, years of XP, and names of rides they work on' do
      visit mechanic_path(@joe)

      expect(page).to have_content("Name: Joe")
      expect(page).to have_content("Ferris Wheel")
      expect(page).to have_content("Jaws")
      expect(page).to have_content("Years Experience: 8")
    end
  end
end