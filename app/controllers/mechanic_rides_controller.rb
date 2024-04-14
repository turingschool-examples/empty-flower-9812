class MechanicRidesController < ApplicationController
  def create
    @individual_mechanic = Mechanic.find(params[:id])
    @individual_ride = Ride.find(params[:ride_id])

    new_mechanic_ride = MechanicRide.create!(ride_id: @individual_ride.id, mechanic_id: @individual_mechanic.id)

    redirect_to "/mechanics/#{@individual_mechanic.id}"
  end
end