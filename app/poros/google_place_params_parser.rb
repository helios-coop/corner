# frozen_string_literal: true

class GooglePlaceParamsParser
  ADDR_COMPONENTS_MAP = {
    street_number: :street_number,
    route: :route,
    locality: :city,
    administrative_area_level_1: :state,
    country: :country,
    postal_code: :zipcode,
  }.freeze

  def call(params)
    g_place = JSON.parse(params).deep_symbolize_keys

    phone = g_place[:formatted_phone_number]
    phone = phone.gsub(/[()+\s-]/, "") if phone

    attrs = {
      name: g_place[:name],
      phone: phone,
      url: g_place[:website],
      lat: g_place[:geometry][:location][:lat],
      long: g_place[:geometry][:location][:lng],
      thumbnail_url: g_place[:thumbnailUrl],
      google_places_id: g_place[:place_id],
    }

    g_place[:address_components].each do |component|
      component_type = component[:types][0].to_sym
      address_component = ADDR_COMPONENTS_MAP[component_type]

      next unless address_component

      attrs[address_component] =
        if address_component == :city
          component[:long_name]
        else
          component[:short_name]
        end
    end
    attrs[:address] = "#{attrs.delete(:street_number)} #{attrs.delete(:route)}"
    attrs
  end
end
