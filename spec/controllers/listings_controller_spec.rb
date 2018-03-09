# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController do
  let(:satoshi) { create(:user, display_name: 'satoshi') }
  let!(:listing) { create(:listing, submitter: satoshi) }

  describe 'GET #index' do
    before { get :index }

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'finds all listings in the db' do
      expect(assigns(:listings).count).to eq 1
    end
  end

  describe 'GET #new' do
    before do
      login(satoshi)
      get :new
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      login(satoshi)
      get :edit, params: { id: listing.id }
    end

    it 'renders the index template' do
      expect(response).to render_template :edit
    end

    it 'finds the correct listing' do
      expect(assigns(:listing).name).to eq listing.name
    end
  end

  describe 'POST #create' do
    let(:bitcoin) { create(:currency) }
    let(:currency_params) { [bitcoin.id] }
    let(:listing_params)  { { name: 'Pub Satoshi', submitter_id: satoshi.id } }

    context 'when a user is logged in' do
      before do
        login(satoshi)
        post :create, params: { listing: listing_params,
                                currencies: currency_params }
      end

      it 'adds a listing to the database' do
        expect(Listing.count).to eq 2
      end

      it 'sets the submitter correctly' do
        expect(Listing.last.submitter).to eq satoshi
      end

      it 'adds currencies to a listing' do
        expect(assigns(:listing).currencies.pluck(:name)).to eq ['Bitcoin']
      end
    end

    context 'when a user is not logged in' do
      before do
        post :create, params: { listing: listing_params }
      end

      it 'adds a listing to the database' do
        expect(Listing.count).to eq 1
      end
    end
  end
end
