require "rails_helper"

RSpec.describe Mechanic, type: :model do
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

  describe "relationships" do
    it { should have_many(:mechanic_rides) }
    it { should have_many(:rides).through(:mechanic_rides) }
  end

  it '#add_ride' do
    @john.add_ride(@jaws.id)
    
    expect(@john.rides).to include(@jaws)
  end
end