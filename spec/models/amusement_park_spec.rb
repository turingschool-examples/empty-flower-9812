require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides) }
  end

  describe "instance methods" do
    it '#unique_mechanics' do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      @dave = Mechanic.create!(name: "Dave Williams", years_experience: 30)
      @barbara = Mechanic.create!(name: "Barbara Jones", years_experience: 15)
      @kyle = Mechanic.create!(name: "Kyle Smith", years_experience: 22)
      MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @dave.id)
      MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @dave.id)
      MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @dave.id)
      MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @barbara.id)
      MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @barbara.id)
      MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @kyle.id)
      MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @kyle.id)

      expect(@six_flags.unique_mechanics).to eq([@dave, @barbara, @kyle])
    end
  end
end