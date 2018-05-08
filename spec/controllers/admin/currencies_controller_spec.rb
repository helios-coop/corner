# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::CurrenciesController, type: :controller do
  let(:bitcoin) { currencies(:bitcoin) }
  let(:litecoin) { currencies(:litecoin) }
  let(:admin) { users(:admin) }

  describe "GET #index" do
    before do
      login(admin)
      get :index
    end

    context "when current_user is an admin" do
      it "returns a collection of currencies" do
        expect(assigns(:currencies)).to include(litecoin, litecoin)
      end
    end
  end

  describe "GET #new" do
    context "when current_user is an admin" do
      before do
        login(admin)
        get :new
      end

      it "renders new template" do
        expect(response).to render_template :new
      end
    end

    context "when current_user is not an admin" do
      before do
        get :new
      end

      it "returns the listings template" do
        expect(response).not_to render_template :new
      end
    end
  end

  describe "POST #create" do
    before { login(admin) }
    let(:valid_params) { { name: "Ripple", symbol: "XRP" } }

    context "when current_user is an admin" do
      it "creates a new currency" do
        post :create, params: { currency: valid_params }
        expect(assigns(:currency)).to be_persisted
      end
    end

    context "when given invalid params" do
      it "renders the :new template" do
        post :create, params: { currency: valid_params.merge(name: "") }
        expect(assigns(:currency)).not_to be_persisted
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    before { login(admin) }

    it "assigns @currency" do
      get(:edit, params: { id: bitcoin.id })
      expect(assigns(:currency)).to eq bitcoin
    end
  end

  describe "#update" do
    before { login(admin) }

    let(:valid_params) { { name: "Watcoin", symbol: "WAT" } }

    context "when params are valid" do
      it "flashes a success message" do
        patch(:update, params: { currency: valid_params, id: bitcoin.id })
        expect(flash[:success]).to eq("Currency updated.")
      end

      it "updates the currency" do
        expect do
          patch(:update, params: { currency: valid_params, id: bitcoin.id })
        end.to change { bitcoin.reload.name }.to("Watcoin")
      end

      it "redirects to currencies path" do
        patch(:update, params: { currency: valid_params, id: bitcoin.id })
        expect(response).to redirect_to(admin_currencies_path)
      end
    end

    context "when params are invalid" do
      it "does not update the currency" do
        expect do
          patch(:update, params: { currency: { name: nil }, id: bitcoin.id })
        end.not_to change { bitcoin.reload.name }.from("Bitcoin")
      end

      it "renders the new template" do
        patch(:update, params: { currency: { name: nil }, id: bitcoin.id })

        expect(response).to render_template(:new)
      end
    end
  end
end
