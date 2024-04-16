class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @rides = @mechanic.rides
    @mechanic.add_ride(params[:ride_id])
    
    redirect_to mechanic_path(@mechanic)
  end

end