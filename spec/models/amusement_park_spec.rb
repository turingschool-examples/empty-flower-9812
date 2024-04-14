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

    describe '#rides_by_avg_mechanic_experience' do
      it 'returns a list of all its rides ordered by average mechanic experience and also has access to each rides average mechanic experience' do
        mechanic4 = Mechanic.create!(name: 'Fourth Mechanic', years_experience: 3)
        mechanic4.rides << @ride2
        @mechanic2.rides << @ride2
        @mechanic3.rides << @ride2

        list_of_rides = @park1.rides_by_avg_mechanic_experience

        expect(list_of_rides).to eq([@ride3, @ride1, @ride2])

        expect(list_of_rides.first.average_experience.round).to eq(19)
        expect(list_of_rides.second.average_experience.round).to eq(10)
        expect(list_of_rides.last.average_experience.round).to eq(9)
      end
    end
  end
end
