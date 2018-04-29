# frozen_string_literal: true

require "rails_helper"

RSpec.describe ListingsController do
  let(:satoshi) { users(:satoshi) }
  let(:bitcoin)  { currencies(:bitcoin) }
  let(:litecoin) { currencies(:litecoin) }
  let(:tron)     { currencies(:tron) }
  let!(:listing) do
    create(:listing, submitter: satoshi, lat: 37.791139, long: -122.396067)
  end

  describe "GET #index" do
    before { get :index }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds all listings in the db" do
      expect(assigns(:listings).count(:all)).to eq 1
    end
  end

  describe "GET #new" do
    before do
      login(satoshi)
      get :new
    end

    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    context "when current user is the submitter" do
      before do
        login(satoshi)
        get :edit, params: { id: listing.id }
      end

      it "renders the index template" do
        expect(response).to render_template :edit
      end

      it "finds the correct listing" do
        expect(assigns(:listing).name).to eq listing.name
      end
    end

    context "when current_user is not the submitter, admin or moderator" do
      let(:justin_sun) { create(:user, display_name: "justin") }
      let(:valid_params) { { id: listing.id } }

      before do
        login(justin_sun)
        get :edit, params: valid_params
      end

      it "redirects to the listings page" do
        expect(response).to redirect_to(listings_path)
      end

      it "set the flash" do
        expect(flash[:danger]).to eq "Sorry, you cannot edit this listing"
      end
    end
  end

  describe "PATCH #update" do
    let(:valid_params) do
      {
        id: listing.id,
        currencies: [litecoin.id, tron.id],
        listing: { name: "whatevs" },
      }
    end

    context "when current_user is an admin" do
      before do
        login(satoshi)
        listing.currencies = [bitcoin, litecoin]
        patch :update, params: valid_params
      end

      it "updates currencies" do
        currency_names = listing.reload.currencies.pluck(:name)
        expect(currency_names).to match_array ["Litecoin", "Tron"]
      end

      it "soft deletes removed currencies" do
        deleted_currencies_listings =
          listing.reload.currencies_listings.only_deleted
        expect(deleted_currencies_listings.length).to eq 1
        expect(deleted_currencies_listings.first.currency).to eq bitcoin
      end
    end

    context "when current_user is the submitter" do
      let(:justin_sun) { create(:user, display_name: "justin", role: "user") }
      let(:listing2) do
        create(:listing,
               google_places_id: 12_345,
               submitter: justin_sun,
               lat: 37.791139, long: -122.396067,)
      end

      before do
        login(justin_sun)
        listing2.currencies = [bitcoin, litecoin]
        patch :update, params: valid_params.merge(id: listing2.id)
      end

      it "updates currencies" do
        currency_names = listing2.reload.currencies.pluck(:name)
        expect(currency_names).to match_array ["Litecoin", "Tron"]
      end
    end

    context "when current_user is not the submitter, admin or moderator" do
      let(:justin_sun) { create(:user, display_name: "justin", role: "user") }

      before do
        login(justin_sun)
        listing.currencies = [bitcoin, litecoin]
        patch :update, params: valid_params
      end

      it "does not update currencies" do
        currency_names = listing.reload.currencies.pluck(:name)
        expect(currency_names).to match_array ["Bitcoin", "Litecoin"]
      end

      it "set the flash" do
        expect(flash[:danger]).to eq "Sorry, you cannot edit this listing"
      end
    end
  end

  describe "POST #create" do
    let(:bitcoin) { currencies(:bitcoin) }
    let(:currency_params) { [bitcoin.id] }
    let(:google_place_params) do
      File.read(File.join(fixture_path, "places.json"))
    end

    let(:valid_params) { { 'google-place': google_place_params }.merge(from_google_places: "true") }

    context "when a user is logged in" do
      before do
        login(satoshi)
        post :create, params: valid_params.merge(currencies: currency_params)
      end

      it "adds a listing to the database" do
        expect(Listing.count).to eq 2
      end

      it "sets the submitter correctly" do
        expect(Listing.last.submitter).to eq satoshi
      end

      it "adds currencies to a listing" do
        expect(assigns(:listing).currencies.pluck(:name)).to eq ["Bitcoin"]
      end
    end

    context "when params are invalid" do
      let(:invalid_params) { { listing: { name: nil } } }

      before { login(satoshi) }

      it "flashes an error" do
        post(:create, params: invalid_params)
        expect(flash[:danger]).to match(/horribly wrong/)
      end

      it "assigns currencies" do
        post(:create, params: invalid_params)
        expect(assigns(:currencies)).to match_array(Currency.all)
      end

      it "renders the :new template" do
        post(:create, params: invalid_params)
        expect(response).to render_template(:new)
      end
    end

    context "when a user is not logged in" do
      before do
        post :create, params: valid_params
      end

      it "adds a listing to the database" do
        expect(Listing.count).to eq 1
      end
    end
  end

  describe "GET #show" do
    before do
      login(satoshi)
      post :show, xhr: true, params: { id: listing.id, format: "js" }
    end

    it "finds the correct listing via ajax call" do
      expect(assigns(:listing).name).to eq listing.name
    end
  end
end
