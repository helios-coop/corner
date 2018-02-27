class LocationsController < ApplicationController
  def index
    @locations = Location.all
    @name = 'David'
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.create(location_params)
    # Todo add in currencies
    redirect_to locations_path
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update_attributes(location_params)
    # Todo add in currencies
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :phone, :url)
  end
end
