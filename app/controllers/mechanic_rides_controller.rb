class MechanicRidesController < ApplicationController
  def update
    @mechanic = Mechanic.find(params[:id])
    @mechanic_rides = @mechanic.mechanic_rides

    @mechanic_rides.update(update_params)
    redirect_to mechanic_path(@mechanic)
  end

  private 

  def update_params
    params.permit(:ride_id)
  end
end