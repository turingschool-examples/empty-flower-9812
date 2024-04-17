class MechanicsController < ApplicationController
  # def index
  #   @mechanics = Mechanic.all
  # end

  def show
    @mechanic = Mechanic.find(params[:name])
  end
end
