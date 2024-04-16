class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @rides = @mechanic.rides
  end

  def update
    @mechanic = Mechanic.find(params[:id])
    ride_id = params[:ride_id]

    if ride_id.present?
      @mechanic.add_ride(ride_id)

      redirect_to mechanic_path(@mechanic)
    end
  end
end