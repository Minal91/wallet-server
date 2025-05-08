require 'rails_helper'

RSpec.describe BalanceController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns a successful response and includes the current balance" do
      get :show, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include(
        "current_balance" => 1000
      )
    end
  end
end