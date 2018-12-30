require 'rails_helper'

RSpec.describe Api::V1::ScreensController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #transactions" do
    it "returns http success" do
      get :transactions
      expect(response).to have_http_status(:success)
    end
  end

end
