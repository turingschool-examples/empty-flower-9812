require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:ride_mechanics) }
    it { should have_many(:mechanics) }
  end

  describe "instance methods" do
    describe "#mechanics_on_rides" do
      it "displays the unique mechanics that work on rides at that park" do
        @park1 = AmusementPark.create!(name: "Six Flags", admission_cost: 50)
        @mechanic1 = Mechanic.create!(name: "Tom", years: 20)
        @mechanic2 = Mechanic.create!(name: "Joe", years: 40)
        @mechanic3 = Mechanic.create!(name: "Eric", years: 1)
        @ride1 = @park1.rides.create!(name: "Twister", thrill_rating: 10, open: true)
        @ride2 = @park1.rides.create!(name: "Teapots", thrill_rating: 2, open: true)
        @ride3 = @park1.rides.create!(name: "Jumper", thrill_rating: 5, open: true)

        @mechanic1.rides << [@ride1, @ride2]
        @mechanic2.rides << [@ride2, @ride3]

        expect(@park1.mechanics_on_rides).to match_array([@mechanic1, @mechanic2])
      end
    end
  end
end