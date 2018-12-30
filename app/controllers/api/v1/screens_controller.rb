class Api::V1::ScreensController < ApplicationController
  def home
  end

  def transactions
    wallets = Wallet.find(params[:wallet_ids])
    transactions = wallets.map { |w| w.fetch_transactions(format_response = true) }
    render json: decorate(transactions)
  end

  private

  def decorate(transactions)
    transactions.flatten.group_by { |t| t[:date] }
  end
end
