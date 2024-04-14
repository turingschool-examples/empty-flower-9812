require "rails_helper"

RSpec.describe Mechanic, type: :model do
  describe "relationships" do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides).through(:ride_mechanics) }
    it { should have_many(:amusement_parks).through(:rides) }
  end
end