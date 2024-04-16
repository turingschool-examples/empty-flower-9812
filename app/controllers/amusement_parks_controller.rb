class AmusementParksController < ApplicationController
  def show
    amusement_park = AmusementPark.find(params[:id])
    @rides = @amusement_park.rides
    @mechanics = @amusement_park.unique_list_of_mechanics
  end
end