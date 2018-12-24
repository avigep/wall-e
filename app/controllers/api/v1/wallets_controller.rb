module Api
  module V1
    class Api::V1::WalletsController < ApplicationController
      before_action :set_wallet, only: [:show, :update, :destroy]

      # GET /api/v1/wallets
      def index
        @wallets = Wallet.all

        render json: @wallets
      end

      # GET /api/v1/wallets/1
      def show
        render json: @wallet
      end

      # POST /api/v1/wallets
      def create
        @wallet = Wallet.new(wallet_params)

        if @wallet.save
          render json: @wallet, status: :created, location: api_v1_wallet_url(@wallet)
        else
          render json: @wallet.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/wallets/1
      def update
        if @wallet.update(wallet_params)
          render json: @wallet
        else
          render json: @wallet.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/wallets/1
      def destroy
        @wallet.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_wallet
        @wallet = Wallet.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def wallet_params
        #params.fetch(:wallet, {})
        params.require(:wallet).permit(:name, :address)
      end
    end
  end
end