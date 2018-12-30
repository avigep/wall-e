require 'rails_helper'

RSpec.describe Api::V1::ScreensController, type: :request do
  let!(:wallet) { FactoryBot.create(:wallet) }

  describe 'GET /api/v1/screens/transactions' do
    context 'when request is valid' do
      context 'when filter_response param is present' do
        before { get api_v1_screens_transactions_path, params: { wallet_ids: [wallet.id] } }
        it { expect(response).to have_http_status(200) }
        it { expect(json[json.keys[0]].first.keys.map &:to_sym).to contain_exactly(:type, :amount, :date, :timestamp, :wallet_name) }
      end
    end
  end
end
