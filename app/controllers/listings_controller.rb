# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: [:index]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
    @currencies = Currency.all
  end

  def create
    @listing = Listing.new(listing_params.merge(submitter_id: current_user.id))

    if @listing.save
      currencies = Currency.where(id: params[:currencies])
      @listing.currencies << currencies

      redirect_to listings_path
    else
      flash[:error] = 'Something has gone horribly wrong. Listing not created.'
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
    @currencies = Currency.all
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update_attributes(listing_params)
    # Todo add in currencies
    redirect_to listings_path
  end

  private

  PERMITTED_PARAMS = %i[
    name
    address
    address2
    city
    state
    zipcode
    country
    phone
    url
    submitter_id
  ].freeze

  def listing_params
    params.require(:listing).permit(*PERMITTED_PARAMS)
  end
end
