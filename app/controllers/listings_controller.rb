# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :authorize, except: [:index, :show]

  def index
    set_listings
    set_map_center_point unless gon.centerPoint
    @categories = Category.all.pluck(:name)

    return if @listings.blank?
    @listing = @listings.first
    create_google_place_variables(@listing.google_places_id)
  end

  def new
    @listing = Listing.new
    @currencies = Currency.all
    @all_categories = Category.all.pluck(:name)
    @listing_categories = []
  end

  def create
    listing_attributes = listing_attributes_from_params
    @listing = Listing.new(listing_attributes.merge(submitter: current_user))

    if @listing.save
      @listing.categories << Category.where(name: params[:categories])
      SlackNotifier.new.call(:new_listing, listing: @listing)

      redirect_to listings_path
    else
      @all_categories = Category.all.pluck(:name)
      @listing_categories = []
      flash[:danger] = "Something has gone horribly wrong. Listing not created."
      @currencies = Currency.all
      @categories = Category.all.pluck(:name)
      @all_categories = Category.all.pluck(:name)
      @listing_categories = []
      render :new
    end
  end

  def show
    @listing = Listing.find(params[:id])

    create_google_place_variables(@listing.google_places_id)

    respond_to { |format| format.js }
  end

  def edit
    @listing = Listing.find(params[:id])
    @all_categories = Category.all.pluck(:name)
    @listing_categories = @listing.categories.pluck(:name)

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
      @listing.categories = Category.where(name: params[:categories])
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
    :online_only,
    currency_ids: [],
    images: [],
  ].freeze

  def listing_params
    params.require(:listing).permit(*PERMITTED_PARAMS)
  end

  def listing_attributes_from_params
    if params[:from_google_places] == "true"
      place_params = GooglePlaceParamsParser.new.call(params["google-place"])
      listing_params.merge(place_params)
    else
      listing_params
    end
  end

  def create_google_place_variables(google_places_id)
    return unless google_places_id

    google_places_client = GooglePlaces::Client.new(google_maps_api_key)
    @google_place = google_places_client.spot(google_places_id)
    @reviews = @google_place.reviews.first(5)
  end

  def set_listings
    search_terms            = {}
    search_terms[:name]     = params[:name]     if params[:name].present?
    search_terms[:location] = params[:location] if params[:location].present?
    search_terms[:category] = params[:category] if params[:category].present?

    if search_terms.present?
      @listings = Listing.full_search(search_terms)
    else
      set_map_center_point
      coordinates = gon.centerPoint.values_at(:latitude, :longitude)
      @listings = Listing.full_search(coordinates: coordinates)
    end

    gon.coordinates = @listings.map(&:coordinates)

    # Until we have enough local listings add in online_only
    if search_terms[:location].present? || search_terms.empty?
      @listings = (@listings + Listing.where.not(online_only: nil)).uniq
    end
  end

  def set_map_center_point
    if params[:location]
      latitude, longitude = Geocoder.coordinates params[:location]
      gon.centerPoint = { latitude: latitude, longitude: longitude, zoom: 13 }
    else
      gon.centerPoint = center_point_from_ip_address
    end
  end

  def center_point_from_ip_address
    {
      latitude: request.location.data["latitude"],
      longitude: request.location.data["longitude"],
      zoom: 13,
    }
  end
end
