require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    before { subject }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'finds a new user object' do
      expect(assigns(:user)).to be_a User
    end
  end

  describe 'POST #create' do
    before { subject }

    context 'when password confirmation matches' do
      subject { post :create, params: {user: {display_name: 'AAntonopoulos', email: 'andrea@mastering_bitcoin.com', password: 'permissionless', password_confirmation: 'permissionless'}} }

      it 'creates a new user account' do
        expect(assigns(:user).persisted?).to be true
      end
    end

    context 'when password confirmation does not match' do
      subject { post :create, params: {user: {display_name: 'AAntonopoulos', email: 'andrea@mastering_bitcoin.com', password: 'permissionless', password_confirmation: 'consensys'}} }

      it 'does not create a new user account' do
        expect(assigns(:user).persisted?).to be false
      end
    end
  end
end
