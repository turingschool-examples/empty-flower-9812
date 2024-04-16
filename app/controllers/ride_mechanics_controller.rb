class RideMechanicsController < ApplicationController
  def create
    ride_mechanic = RideMechanic.new(create_ride_mechanic_params)

    if !ride_mechanic.save
      flash[:alert] = "Error: #{ride_mechanic.errors.full_messages}"
    else
      flash[:alert] =
        "You have successfully added a ride to this mechanic's workload."
    end

    redirect_to mechanic_path(params[:mechanic_id])
  end

  private

  def create_ride_mechanic_params
    params.permit(:ride_id, :mechanic_id)
  end
end
