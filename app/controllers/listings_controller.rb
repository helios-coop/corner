# frozen_string_literal: true

class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to listings_path
    else
      flash[:error] = 'Something has gone horribly wrong. Listing not created.'
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update_attributes(listing_params)
    # Todo add in currencies
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :address, :address2, :city, :state, :zipcode, :country, :phone, :url, :submitter_id)
  end
end
