require 'rails_helper'

RSpec.describe Api::V1::WalletsController, type: :request do
  context 'when client token is valid' do
    let!(:wallet) { FactoryBot.create(:wallet) }

    describe 'GET /api/v1/wallets' do
      before do
        get api_v1_wallets_path, headers: headers
      end

      it { expect(response).to have_http_status(200) }
      it { expect(json.size).to eq(1) }
    end

    describe 'GET /api/v1/wallets/:id' do
      context 'when wallet is present' do
        before do
          get api_v1_wallet_path(id: wallet.id)
        end

        it { expect(response).to have_http_status(200) }
        it 'includes required fields in response' do
          expect(json['id']).to eq(wallet.id)
          expect(json['name']).to eq(wallet.name)
          expect(json['address']).to eq(wallet.address)
        end
      end

      context 'when wallet is not present' do
        before do
          get api_v1_wallet_path(id: 'non-existing-id')
        end

        it { expect(response).to have_http_status(404) }
        it { expect(json['error']).to eq('not_found') }
      end
    end

    describe 'POST /api/v1/wallets' do
      context 'when the request is valid' do
        before do
          post api_v1_wallets_path, params: { wallet: FactoryBot.attributes_for(:wallet) }
        end

        it 'creates a wallet' do
          expect(json['address']).to eq('0x0cd62a4e72e4d2f489773ffaebf687952fc65bc3')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before do
          post api_v1_wallets_path, params: { wallet: FactoryBot.attributes_for(:wallet, :invalid_wallet) }
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(json['address'].first).to eq("can't be blank")
        end
      end
    end

    describe 'PATCH /api/v1/wallets/:id' do
      context 'when request is valid' do
        before do
          put api_v1_wallet_path(id: wallet.id),  params: { wallet: { name: 'updated name'} }
        end

        it { expect(response.status).to eq 200 }
        it { expect(json['name']).to eq('updated name') }
      end

      context 'when request is invalid' do
        before do
          put api_v1_wallet_path(id: wallet.id),  params: { wallet: { name: ''} }
        end

        it { expect(response.status).to eq 422 }
        it { expect(json['name'].first).to eq("can't be blank") }
      end
    end

    describe 'DELETE /api/v1/wallets' do
      context 'when request is valid' do
        before { delete api_v1_wallet_path(id: wallet.id) }
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
      context 'when request is invalid' do
        before { delete api_v1_wallet_path(id: 'non-existing-id') }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
