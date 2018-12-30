require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :request do
  let!(:wallet) { FactoryBot.create(:wallet) }

  describe 'GET /api/v1/wallets/:wallet_id/transactions' do
    context 'when wallet_id is valid' do
      context 'when filter_response param is present' do
        before { get api_v1_wallet_transactions_path(wallet_id: wallet.id), params: {format_response: true} }
        it { expect(response).to have_http_status(200) }
        it { expect(json.first.keys.map &:to_sym).to contain_exactly(:amount, :date, :timestamp, :type, :wallet_name) }
      end
      context 'when filter_response param is not present' do
        before { get api_v1_wallet_transactions_path(wallet_id: wallet.id) }
        it { expect(response).to have_http_status(200) }
        it { expect(json.first.keys.map &:to_sym).to include(:blockNumber, :hash, :from, :to, :value) }
      end
    end

    context 'when wallet_id is invalid' do
      before do
        get api_v1_wallet_transactions_path(wallet_id: 'non-existing-id')
      end
      it { expect(response).to have_http_status(404) }
      it { expect(json['error']).to eq('not_found') }
    end
  end
end
