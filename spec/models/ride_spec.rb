require "rails_helper"

RSpec.describe Ride, type: :model do
  describe "relationships" do
    it { should belong_to(:amusement_park) }
    it  {should have_many :mechanic_rides }
    it {should have_many(:mechanics).through(:mechanic_rides)}

  end

  describe '#model methods' do
    it 'displays the rides mechanics' do
      park1 = AmusementPark.create!(name: "Denver", admission_cost: 33)
      ride1 = park1.rides.create!(name: "Tower", thrill_rating: 8, open: true)
      ride2 = park1.rides.create!(name: "Doom", thrill_rating: 8, open: false)
      ride3 = park1.rides.create!(name: "Merry-go-round", thrill_rating: 3, open: true)
      mechanic1 = ride1.mechanics.create!(name: "Martin", years_experience: 10)
      mechanic2 = ride1.mechanics.create!(name: "Rodrigo", years_experience: 9)


      expect(ride1.mechanic_to_ride).to eq([mechanic1.name, mechanic2.name])
      expect(ride2.mechanic_to_ride).to_not eq([mechanic1.name, mechanic2.name])
    end
  end
end