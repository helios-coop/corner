# frozen_string_literal: true

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.before_record do |interaction|
    # make response body plain text rather than binary format
    interaction.response.body.force_encoding("UTF-8")
  end
end
