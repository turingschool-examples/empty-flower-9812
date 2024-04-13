class MechanicController < ApplicationController
  
  def show 
    @mechanic = Mechanic.find(params[:id])
  end
end