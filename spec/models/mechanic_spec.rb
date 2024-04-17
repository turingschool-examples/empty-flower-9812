require "rails_helper"

RSpec.describe Ride, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
  end

  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
  end

  describe "when I visit a mechanic show page" do
    it "sees their name, years of experience, and names of all rides they are working on" do
      visit "/mechanics"

      expect(page).to have_content(@mechanic.name)
    end
  end
end
