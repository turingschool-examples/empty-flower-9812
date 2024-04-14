class MechanicRidesController < ApplicationController
  def create
    mechanic_ride = MechanicRide.create(mechanic_id: params[:mechanic_id], ride_id: params[:ride_id])
    redirect_to mechanic_path(params[:mechanic_id])
  end
end