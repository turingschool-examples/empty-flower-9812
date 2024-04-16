require "rails_helper"

RSpec.describe "Mechanics Show Page" do
  before(:each) do
    @mechanic = Mechanic.create!(
      name: "Bill Wilson",
      years_experience: 8
    )
    @ride1 = Ride.create!(
      name: "Mind Eraser",
      thrill_rating: 8,
      open: true
    )
    @ride2 = Ride.create!(
      name: "Twister III",
      thrill_rating: 7,
      open: true
    )
    @ride1.mechanics << @mechanic
    @ride2.mechanics << @mechanic
  end

  it "shows information about the mechanic" do
    visit "/mechanics/#{@mechanic.id}"

    expect(page).to have_content(@mechanic.name)
    expect(page).to have_content("Years of experience: #{@mechanic.experience}")
    expect(page).to have_content("Rides this mechanic is working on:")
    expect(page).to have_content(@ride1.name)
    expect(page).to have_content(@ride2.name)
  end
end
