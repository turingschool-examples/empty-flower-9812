require "rails_helper"

RSpec.describe AmusementPark, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
    it { should have_many(:mechanics) }
  end

  it "can provide a unique list of mechanics working on the park" do
    mechanic1 = Mechanic.create!(
      name: "Bill Wilson",
      years_experience: 28
    )
    mechanic2 = Mechanic.create!(
      name: "Brenda Jones",
      years_experience: 25
    )
    elitches = AmusementPark.create!(
      name: "Six Flags Elitch Gardens",
      admission_cost: 35
    )
    ride1 = Ride.create!(
      name: "Mind Eraser",
      thrill_rating: 8,
      open: true,
      amusement_park: elitches
    )
    ride2 = Ride.create!(
      name: "Twister III",
      thrill_rating: 7,
      open: true,
      amusement_park: elitches
    )
    ride1.mechanics << mechanic1
    ride2.mechanics << mechanic1
    ride1.mechanics << mechanic2

    expect(elitches.mechanics_list).to eq([mechanic1, mechanic2])
  end
end
