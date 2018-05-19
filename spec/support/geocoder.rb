# frozen_string_literal: true

Geocoder.configure(lookup: :test, ip_lookup: :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      "latitude"  => 37.791139,
      "longitude" => -122.396067,
      "address" => "Oakland, CA, USA",
      "state" => "California",
      "state_code" => "CA",
      "country" => "United States",
      "country_code" => "US",
    },
  ],
)
