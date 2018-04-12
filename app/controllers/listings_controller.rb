# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: [:index, :show]

  def index
    set_listings_and_coordinates

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
      flash[:danger] = "Something has gone horribly wrong. Listing not created."
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
    if @listing.editable_by?(current_user)
      @currencies = Currency.all
    else
      flash[:danger] = "Sorry, you cannot edit this listing"
      redirect_to listings_path
    end
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.editable_by?(current_user)
      @listing.update!(listing_params)
      @listing.currencies = Currency.where(id: params[:currencies])
    else
      flash[:danger] = "Sorry, you cannot edit this listing"
    end
    redirect_to listings_path
  end

  private

  PERMITTED_PARAMS = [
    :address,
    :address2,
    :city,
    :country,
    :lat,
    :long,
    :name,
    :phone,
    :state,
    :thumbnail_url,
    :url,
    :zipcode,
  ].freeze

  def listing_params
    params
      .require(:listing)
      .permit(*PERMITTED_PARAMS)
      .merge(submitter_id: current_user.id)
  end

  ADDR_COMPONENTS_MAP = {
    street_number: :street_number,
    route: :route,
    locality: :city,
    administrative_area_level_1: :state,
    country: :country,
    postal_code: :zipcode,
  }.freeze

  def listing_attributes_from_params
    g_place = JSON.parse(params["google-place"]).deep_symbolize_keys
    attrs = {}

    g_place[:address_components].each do |component|
      component_type = component[:types][0].to_sym
      address_component = ADDR_COMPONENTS_MAP[component_type]

      if address_component == :city
        attrs[address_component] = component[:long_name]
      elsif address_component.present?
        attrs[address_component] = component[:short_name]
      end
    end
    attrs[:name] = g_place[:name]
    if g_place[:formatted_phone_number]
      attrs[:phone] = g_place[:formatted_phone_number].gsub(/[()+\s-]/, "")
    end
    attrs[:address] = "#{attrs.delete(:street_number)} #{attrs.delete(:route)}"
    attrs[:url]   = g_place[:website]
    attrs[:lat]   = g_place[:geometry][:location][:lat]
    attrs[:long] = g_place[:geometry][:location][:lng]
    attrs[:thumbnail_url] = g_place[:thumbnailUrl]
    attrs[:submitter_id] = current_user.id
    attrs[:google_places_id] = g_place[:place_id]
    attrs
  end

  def create_google_place_variables(google_place_id)
    return if Rails.env.test?
    @google_places_client = GooglePlaces::Client.new(google_maps_api_key)
    @google_place = @google_places_client.spot(google_place_id)
    @reviews = @google_place.reviews.first(5)
  end

  def set_listings_and_coordinates
    if params[:location].present?
      @listings = Listing.near(params[:location], 5)

      latitude, longitude = Geocoder.coordinates params[:location]
      gon.centerPoint = { latitude: latitude, longitude: longitude, zoom: 13 }
    else
      gon.centerPoint = center_point_from_ip_address
      @listings = Listing.near([gon.centerPoint[:latitude], gon.centerPoint[:longitude]], 5)
    end

    gon.coordinates = @listings.map(&:coordinates)
  end

  def center_point_from_ip_address
    if Rails.env.production?
      { latitude: request.location.data["latitude"], longitude: request.location.data["longitude"], zoom: 13 }
    else
      { latitude: 37.791139, longitude: -122.396067, zoom: 9 }
    end
  end
end
