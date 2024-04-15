require "rails_helper"

RSpec.describe "the movie show" do
  before(:each) do
    @mechanic1 = Mechanic.create!(name: "Tom", )
  end

  it "displays the name, years of experience and all rides the mechanic works on" do
    visit mechanic_path()

    # As a user,
    # When I visit a mechanic show page
    # I see their name, years of experience, and the names of all rides they are working on.
  end
end