class RideMechanicsController < ApplicationController
  def create
    @mechanic = Mechanic.find(params[:id])
    mechanic_ride = RideMechanic.create(mechanic_id: params[:id], ride_id: params[:ride_id])
    redirect_to "/mechanics/#{@mechanic.id}"
  end
  
  private
  def ride_mechanic_params
    params.permit(:id, :ride_id)
  end
end