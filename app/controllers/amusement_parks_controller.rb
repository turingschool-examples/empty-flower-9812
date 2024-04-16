class AmusementParksController < ApplicationController
  def show
    @park = AmusementPark.find(params[:id])
    @mechanics = @park.mech_name
  end
end