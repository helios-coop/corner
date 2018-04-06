# frozen_string_literal: true

Geocoder.configure(
  timeout: 5,
  lookup: :google,
  ip_lookup: :freegeoip,
  language: :en,
  use_https: false,
  api_key: ENV.fetch("GOOGLE_MAPS_API_KEY"),
  units: :mi,
)
