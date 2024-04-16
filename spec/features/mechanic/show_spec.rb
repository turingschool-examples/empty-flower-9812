require "rails_helper"

RSpec.describe "the mechanic show" do
  before(:each) do
    @mechanic1 = Mechanic.create!(name: "Tom", years: 20)
    @park1 = AmusementPark.create!(name: "Six Flags", admission_cost: 50)
    @ride1 = @park1.rides.create!(name: "Twister", thrill_rating: 10, open: true)
    @ride2 = @park1.rides.create!(name: "Teapots", thrill_rating: 2, open: true)
    @ride3 = @park1.rides.create!(name: "Jumper", thrill_rating: 5, open: true)

    @mechanic1.rides << [@ride1, @ride2]
  end

  it "displays the name, years of experience and all rides the mechanic works on" do
    visit mechanic_path(@mechanic1)
    
    within "#mechanic-#{@mechanic1.id}" do
      expect(page).to have_content("Name: #{@mechanic1.name}")
      expect(page).to have_content("Experience: #{@mechanic1.years} years")
      
      expect(page).to have_content("#{@ride1.name}")
      expect(page).to have_content("#{@ride2.name}")
      expect(page).to_not have_content("#{@ride3.name}")
    end
  end

  it "displays a form to add a ride to their workload" do
    visit mechanic_path(@mechanic1)

    within "#mechanic-#{@mechanic1.id}" do
      expect(page).to have_content("Add a new ride")
      expect(page).to have_button("Submit")
    end
  end

  it "can be filled in with a ride ID and submitted and you're returned to the show page with that ride present" do
    visit mechanic_path(@mechanic1)

    fill_in(:ride_id, with: "#{@ride3.id}")
    click_button("Submit")

    expect(current_path).to eq(mechanic_path(@mechanic1))

    expect(page).to have_content("#{@ride1.name}")
    expect(page).to have_content("#{@ride2.name}")
    expect(page).to have_content("#{@ride3.name}")
  end
end