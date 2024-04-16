require "rails_helper"

RSpec.describe "the amusement park show" do
  before(:each) do
    @park1 = AmusementPark.create!(name: "Six Flags", admission_cost: 50)
    @mechanic1 = Mechanic.create!(name: "Tom", years: 20)
    @mechanic2 = Mechanic.create!(name: "Joe", years: 40)
    @mechanic3 = Mechanic.create!(name: "Eric", years: 1)
    @ride1 = @park1.rides.create!(name: "Twister", thrill_rating: 10, open: true)
    @ride2 = @park1.rides.create!(name: "Teapots", thrill_rating: 2, open: true)
    @ride3 = @park1.rides.create!(name: "Jumper", thrill_rating: 5, open: true)

    @mechanic1.rides << [@ride1, @ride2]
    @mechanic2.rides << [@ride2, @ride3]
  end

  it "displays the name and price of admision for the park" do
    visit amusement_park_path(@park1)

    expect(page).to have_content("Park: #{@park1.name}")
    expect(page).to have_content("Entry Fee: $#{@park1.admission_cost}")
  end

  it "displays the list of all unique mechanics that are working on a parks rides" do
    visit amusement_park_path(@park1)

    within "#mechanics" do
      expect(page).to have_content("Mechanics:")
      expect(page).to have_content("#{@mechanic1.name}")
      expect(page).to have_content("#{@mechanic2.name}")
      expect(page).to have_content("#{@mechanic2.name}")
    end
  end
end