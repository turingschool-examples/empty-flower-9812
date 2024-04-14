require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:ride_mechanics).through(:rides) }
    it { should have_many(:mechanics).through(:ride_mechanics) }
  end

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

  describe '#instance methods' do
    describe '#unique_mechanics' do
      it 'returns a list of unique mechanics working on its rides' do
        list_of_mechanics = @park1.unique_mechanics

        expect(list_of_mechanics).to eq([@mechanic1, @mechanic3])
      end
    end
  end
end
