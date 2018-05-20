# frozen_string_literal: true

RSpec.describe ApplicationController do
  require "browser/testing"

  controller do
    def index
      @listings = []
      render "listings/index"
    end
  end

  describe "#detect_device_variant" do
    context "when device is not mobile" do
      it "does not set a request variant" do
        get(:index)

        expect(request.variant).to eq []
      end

      it "renders the normal template" do
        get(:index)

        expect(response.body).not_to include("mobile-search-bar")
      end
    end

    context "when device is mobile" do
      before { request.env["HTTP_USER_AGENT"] = Browser["IPHONE"] }

      it "sets variant on the request" do
        get(:index)

        expect(request.variant).to eq [:phone]
      end

      it "renders the mobile template" do
        get(:index)

        expect(response.body).to include("mobile-search-bar")
      end
    end
  end
end
