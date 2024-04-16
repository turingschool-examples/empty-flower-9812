class AmusementParksController < ApplicationController
  def show
    @park = AmusementPark.find(params[:id])
    @mechanics = @park.uniq_mechs
  end
end