class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
  end

  def update
    # require 'pry'; binding.pry
    @mechanic = Mechanic.find(params[:id])
    @ride = Ride.find(params[:mechanic][:ride_id])
    @mechanic.rides << @ride
    redirect_to mechanic_path(@mechanic)
  end
end