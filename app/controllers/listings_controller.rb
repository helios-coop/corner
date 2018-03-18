# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: %i[index show]

  def index
    @listings = listings_by_location
    gon.coordinates = @listings.map { |listing| [listing.lat, listing.long] }

    return if @listings.blank?
    @listing = @listings.first
    create_google_place_variables(@listing.google_places_id)
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
      flash[:danger] = 'Something has gone horribly wrong. Listing not created.'
      @currencies = Currency.all
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])
    create_google_place_variables(@listing.google_places_id)

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
    @listing.currencies = Currency.where(id: params[:currencies])
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
    thumbnail_url
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

  # Ahhh, we can clean all this nonsense up with the Ruby Gem: https://github.com/qpowell/google_places
  def listing_attributes_from_params
    g_place = JSON.parse params['google-place']
    attrs = {}

    g_place['address_components'].each do |component|
      if ADDR_COMPONENTS_MAP[component['types'][0].to_sym] == 'city'
        attrs[ADDR_COMPONENTS_MAP[component['types'][0].to_sym].to_sym] = component['long_name']
      elsif ADDR_COMPONENTS_MAP[component['types'][0].to_sym].present?
        attrs[ADDR_COMPONENTS_MAP[component['types'][0].to_sym].to_sym] = component['short_name']
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
    attrs[:thumbnail_url] = g_place['thumbnailUrl']
    attrs[:submitter_id] = current_user.id
    attrs.delete(:street_number)
    attrs.delete(:route)
    attrs[:google_places_id] = g_place['place_id']
    attrs
  end

  def create_google_place_variables(google_place_id)
    return if Rails.env.test?
    @google_places_client = GooglePlaces::Client.new(ENV['GOOGLE_MAPS_API_KEY'])
    @google_place = @google_places_client.spot(google_place_id)
    @reviews = @google_place.reviews[0..4]
  end

  def listings_by_location
    if params[:location].present?
      Listing.near(params[:location])
    else
      @listings = Listing.limit(10).order(:name)
    end
  end
end
