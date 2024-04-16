class MechanicsController < ApplicationController
  def new
    @mechanic = Mechanic.new
    @ride = Ride.new
  end

  def create
    mechanic = Mechanic.create(mechanic_params)
    redirect_to "/mechanics"
  end
  
  def show
    @mechanic = Mechanic.find(params[:id])
  end

  private
  def mechanic_params
    params.require(:mechanic).permit(:name, :years)
  end
end