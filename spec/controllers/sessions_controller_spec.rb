require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:satoshi) { User.create(display_name: 'satoshi', email: 'satoshi@gmail.com', password: '12345', password_confirmation: '12345') }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with a correct email and password' do
      it 'logs the user in' do
        post :create, params: { email: 'satoshi@gmail.com', password: '12345' }
        expect(session[:id]).to be_present
      end
    end

    context 'with an incorrect email and password' do
      it 'does not log the user in' do
        post :create, params: { email: 'satoshi@gmail.com', password: 'bad_password' }
        expect(session[:id]).to be nil
      end
    end
  end

  describe 'GET #destroy' do
    it 'logs the user out' do
      get :destroy
      expect(session[:id]).to be nil
    end
  end
end