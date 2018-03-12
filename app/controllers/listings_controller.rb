# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: [:index]

  def index
    @listings = Listing.all
    @listing = @listings.first
  end

  def new
    @listing = Listing.new
    @currencies = Currency.all
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      @listing.currencies = Currency.where(id: params[:currencies])

      redirect_to listings_path
    else
      flash[:error] = 'Something has gone horribly wrong. Listing not created.'
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def edit
    @listing = Listing.find(params[:id])
    @currencies = Currency.all
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update!(listing_params)
    update_currencies
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
    lat
    long
  ].freeze

  def listing_params
    params
      .require(:listing)
      .permit(*PERMITTED_PARAMS)
      .merge(submitter_id: current_user.id)
  end

  def update_currencies
    new_currencies = Currency.where(id: params[:currencies])

    @listing.remove_currencies(new_currencies)
    @listing.add_new_currencies(new_currencies)
  end
end
