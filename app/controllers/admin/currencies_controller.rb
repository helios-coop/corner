# frozen_string_literal: true

module Admin
  class CurrenciesController < ApplicationController
    before_action :authorize_admin

    def index
      @currencies = Currency.all
    end

    def new
      @currency = Currency.new
    end

    def create
      @currency = Currency.new(currency_params)

      if @currency.save
        flash[:success] = 'Currency created.
                            It\'s like your own person a ICO just happened.'
        redirect_to admin_currencies_path
      else
        render :new
      end
    end

    def edit
      @currency = Currency.find(params[:id])
    end

    def update
      @currency = Currency.find(params[:id])

      if @currency.update(currency_params)
        flash[:success] = 'Currency updated.'
        redirect_to admin_currencies_path
      else
        render :new
      end
    end

    private

    def currency_params
      params.require(:currency).permit(:name, :symbol)
    end
  end
end
