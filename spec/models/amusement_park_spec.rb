require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  before :each do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @john = Mechanic.create!(id: 1, name: 'John', years_experience: 5)
    @joe = Mechanic.create!(id: 2, name: 'Joe', years_experience: 8)

    @john.rides << @hurler #SF 
    @john.rides << @scrambler #SF

    @joe.rides << @ferris #SF
    @joe.rides << @jaws #U
  end

  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:mechanics) }
  end

  it '#unique_list_of_mechanics' do
    expect(@six_flags.unique_list_of_mechanics).to eq([@john, @joe])
    expect(@universal.unique_list_of_mechanics).to eq([@joe])
  end
end