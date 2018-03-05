# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'finds a new user object' do
      expect(assigns(:user)).to be_a User
    end
  end

  describe 'POST #create' do
    context 'when password confirmation matches' do
      let(:user_params) do
        {
          display_name: 'AAntonop',
          email: 'andrea@mastering_bitcoin.com',
          password: 'permissionless',
          password_confirmation: 'permissionless'
        }
      end

      it 'creates a new user account' do
        post :create, params: { user: user_params }
        expect(assigns(:user).persisted?).to be true
      end
    end

    context 'when password confirmation does not match' do
      let(:user_params) do
        {
          display_name: 'AAntonop',
          email: 'andrea@mastering_bitcoin.com',
          password: 'permissionless',
          password_confirmation: 'consenys'
        }
      end

      it 'does not create a new user account' do
        post :create, params: { user: user_params }
        expect(assigns(:user).persisted?).to be false
      end
    end
  end
end
