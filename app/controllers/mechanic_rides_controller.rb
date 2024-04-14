class MechanicRidesController < ApplicationController
  
  def create
    
    @mechanic_rides = MechanicRide.create!(mechanic_id: params[:id], ride_id: params[:ride_id])

    redirect_to "/mechanic/#{params[:id]}"
  end

end