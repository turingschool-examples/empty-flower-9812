require "rails_helper"

RSpec.describe "Mechanics Show Page" do
  before(:each) do
    @mechanic = Mechanic.create!(
      name: "Bill Wilson",
      years_experience: 8
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
    @ride1.mechanics << @mechanic
    @ride2.mechanics << @mechanic
  end

  it "shows information about the mechanic" do
    visit "/mechanics/#{@mechanic.id}"

    expect(page).to have_content(@mechanic.name)
    expect(page).to have_content("Years of experience: #{@mechanic.years_experience}")
    expect(page).to have_content("Rides this mechanic is working on:")
    expect(page).to have_content(@ride1.name)
    expect(page).to have_content(@ride2.name)
  end

  it "has a form to add a new ride to the mechanic" do
    visit "/mechanics/#{@mechanic.id}"

    within "form" do
      expect(page).to have_content("Add a ride to workload:")
      expect(page).to have_field("ride_id")
      expect(page).to have_button("submit")
    end
  end

  it "can add a new ride to the mechanic" do
    visit "/mechanics/#{@mechanic.id}"

    fill_in("ride_id", with: @ride3.id)
    click_button("submit")

    expect(page).to have_current_path("/mechanics/#{@mechanic.id}")

    expect(page).to have_content(
      "You have successfully added a ride to this mechanic's workload."
    )

    within "#mechanic-rides" do
      expect(page).to have_content(@ride3.name)
    end
  end

  it "requires a valid ride id" do
    visit "/mechanics/#{@mechanic.id}"

    fill_in("ride_id", with: "")
    click_button("submit")

    expect(page).to have_current_path("/mechanics/#{@mechanic.id}")
    expect(page).to have_content("Ride must exist")

    fill_in("ride_id", with: 0)
    click_button("submit")

    expect(page).to have_current_path("/mechanics/#{@mechanic.id}")
    expect(page).to have_content("Ride must exist")
  end
end
