# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with a correct email and password' do
      it 'logs the user in' do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to be user.id
      end
    end

    context 'with an incorrect email and password' do
      it 'does not log the user in' do
        post :create, params: { email: user.email, password: 'bad_password' }
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
