require "rails_helper"

RSpec.describe "Mechanics Show Page" do
  before(:each) do
    @mechanic1 = Mechanic.create!(
      name: "Bill Wilson",
      years_experience: 28
    )
    @mechanic2 = Mechanic.create!(
      name: "Brenda Jones",
      years_experience: 25
    )
    @mechanic3 = Mechanic.create!(
      name: "Dr. Bob",
      years_experience: 31
    )
    @elitches = AmusementPark.create!(
      name: "Six Flags Elitch Gardens",
      admission_cost: 35
    )
    @ride1 = Ride.create!(
      name: "Mind Eraser",
      thrill_rating: 8,
      open: true,
      amusement_park: @elitches
    )
    @ride2 = Ride.create!(
      name: "Twister III",
      thrill_rating: 7,
      open: true,
      amusement_park: @elitches
    )
    @ride3 = Ride.create!(
      name: "Sidewinder",
      thrill_rating: 7,
      open: true,
      amusement_park: @elitches
    )
    @ride1.mechanics << @mechanic1
    @ride2.mechanics << @mechanic1
    @ride3.mechanics << @mechanic1
    @ride1.mechanics << @mechanic2
  end

  it "has the name and price of admissions" do
    visit "/amusement_parks/#{@elitches.id}"

    expect(page).to have_content(@elitches.name)
    expect(page).to have_content(
      "Price of admission: $#{@elitches.admission_cost}"
    )
  end

  it "has a unique list of all mechanics working on the park" do
    visit "/amusement_parks/#{@elitches.id}"

    within "#park-mechanics" do
      expect(page).to have_content("Mechanics working on this park:")
      expect(page).to have_text(@mechanic1.name, count: 1)
      expect(page).to have_text(@mechanic2.name, count: 1)
      expect(page).to_not have_content(@mechanic3.name)
    end
  end
end
