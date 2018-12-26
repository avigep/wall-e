module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_wallet, only: [:index]

      # GET /api/v1/transactions
      def index
        @transactions = @wallet.fetch_transactions(params[:format_response] == 'true')
        render json: @transactions
      end

      private

      def set_wallet
        @wallet = Wallet.find(params[:wallet_id])
      end
    end
  end
end
