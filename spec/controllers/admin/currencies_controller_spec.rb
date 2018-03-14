# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CurrenciesController, type: :controller do
  let(:btc) { create(:currency, name: 'Bitcoin',  symbol: 'LTC') }
  let(:ltc) { create(:currency, name: 'Litecoin', symbol: 'LTC') }
  let(:admin) { create(:user, role: 'Admin') }

  describe 'GET #index' do
    before do
      login(admin)
      get :index
    end

    context 'when current_user is an admin' do
      it 'returns a collection of currencies' do
        expect(assigns(:currencies)).to include(btc, ltc)
      end
    end
  end

  describe 'GET #new' do
    context 'when current_user is an admin' do
      before do
        login(admin)
        get :new
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end
    end

    context 'when current_user is not an admin' do
      before do
        get :new
      end

      it 'returns the listings template' do
        expect(response).not_to render_template :new
      end
    end
  end

  describe 'POST #create' do
    before do
      login(admin)
      post :create, params: { currency: { name: 'Tron', symbol: 'TRX' } }
    end

    context 'when current_user is an admin' do
      it 'creates a new currency' do
        expect(assigns(:currency)).to be_persisted
      end
    end
  end
end
