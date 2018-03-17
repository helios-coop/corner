# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: %i[index show]

  def index
    @listings = Listing.order(:name)
    gon.coordinates = @listings.pluck(:lat, :long)
    @listing = @listings.first
  end

  def new
    @listing = Listing.new
    @currencies = Currency.all
  end

  def create
    listing_attributes = listing_attributes_from_params
    @listing = Listing.new(listing_attributes)

    if @listing.save
      @listing.currencies = Currency.where(id: params[:currencies])

      redirect_to listings_path
    else
      flash[:error] = 'Something has gone horribly wrong. Listing not created.'
      @currencies = Currency.all
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

  ADDR_COMPONENTS_MAP = {
    street_number: 'street_number',
    route: 'route',
    locality: 'city',
    administrative_area_level_1: 'state',
    country: 'country',
    postal_code: 'zipcode'
  }.freeze

  # Fuck you google places. Seriously the worst API ever.
  # What the actual fuck were you thinking with the data structure
  # returned from 'autocomplete.getPlace()'.
  # Its like a bad interview question.
  # https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform?utm_source=welovemapsdevelopers&utm_campaign=mdr-gdl#style_autocomplete
  def listing_attributes_from_params
    g_place = JSON.parse params['google-place']
    attrs = {}

    g_place['address_components'].each do |component|
      if ADDR_COMPONENTS_MAP[component['types'][0].to_sym]
        attrs[ADDR_COMPONENTS_MAP[component['types'][0].to_sym].to_sym] =
          component['short_name']
      end
    end
    attrs[:name] = g_place['name']
    if g_place['formatted_phone_number']
      attrs[:phone] = g_place['formatted_phone_number'].gsub(/[()+\s-]/, '')
    end
    attrs[:address] = "#{attrs[:street_number]} #{attrs[:route]}"
    attrs[:url]   = g_place['website']
    attrs[:lat]   = g_place['geometry']['location']['lat']
    attrs[:long] = g_place['geometry']['location']['lng']
    attrs[:submitter_id] = current_user.id
    attrs.delete(:street_number)
    attrs.delete(:route)
    attrs[:google_places_id] = g_place['id']
    attrs
  end

  def update_currencies
    new_currencies = Currency.where(id: params[:currencies])

    @listing.remove_currencies(new_currencies)
    @listing.add_new_currencies(new_currencies)
  end
end
