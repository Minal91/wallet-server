require 'rails_helper'

RSpec.describe BalanceController, type: :controller do
  let(:user) { create(:user) }
  let!(:credit_transaction) { create(:credit_transaction, amount: 1000, description: "Test Credit", user: user) }    

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns a successful response and includes the current balance" do
      get :details, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include(
        "current_balance" => "1000.0"
      )
    end
  end
end