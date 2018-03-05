require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before { User.create(display_name: 'satoshi', email: 'satoshi@gmail.com', password: 'segwit2x', password_confirmation: 'segwit2x') }

    context 'with a correct email and password' do
      it 'logs the user in' do
        post :create, params: { email: 'satoshi@gmail.com', password: 'segwit2x' }
        expect(session[:user_id]).to be_present
      end
    end

    context 'with an incorrect email and password' do
      it 'does not log the user in' do
        post :create, params: { email: 'satoshi@gmail.com', password: 'bad_password' }
        expect(session[:user_id]).to be nil
      end
    end
  end

  describe 'GET #destroy' do
    it 'logs the user out' do
      get :destroy
      expect(session[:user_id]).to be nil
    end
  end
end
