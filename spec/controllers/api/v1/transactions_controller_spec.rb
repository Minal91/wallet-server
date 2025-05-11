require 'rails_helper'
RSpec.describe Api::V1::TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:receiver) { create(:user) }
  let!(:credit_transaction) { create(:credit_transaction, amount: 1000, description: "Test Credit", user: user) }
  let!(:debit_transaction) { create(:debit_transaction, amount: 10, description: "Test Debit", user: user) }
  let!(:transfer_transaction) { create(:transfer_transaction, sender: user, receiver: receiver, amount: 100, description: "Test Transfer", user: user) }

  before do
      sign_in user
  end

  describe "GET #index" do

      it "returns a successful response and assigns transactions" do
          get :index, format: :json
          expect(response).to have_http_status(:success)
          expect(assigns(:transactions)).to include(credit_transaction, debit_transaction, transfer_transaction)
      end
  end

  describe "POST #create" do
      context "when creating a credit transaction" do
          context "with valid parameters" do
              it "creates a new transaction and redirects" do
                  expect {
                      post :create, params: { transaction: { amount: 50, description: "New Credit Transaction", type: "CreditTransaction"} }
                  }.to change(Transaction, :count).by(1)
                  parsed_response = JSON.parse(response.body)
                  expect(response).to have_http_status(:success)
                  expect(parsed_response.keys).to include("transaction_id", "amount", "type", "created_at", "updated_at")
                  expect(parsed_response["amount"]).to eq(50)
              end
          end

          context "with zero amount" do
            it "doesn't create a transaction and renders :new" do
                expect {
                    post :create, params: { transaction: { amount: 0, description: "New Credit Transaction", type: "CreditTransaction", receiver_id: receiver.id } }
            }.not_to change(Transaction, :count)
                parsed_response = JSON.parse(response.body)
                expect(parsed_response["errors"]).to include("Amount must be greater than 0")
                expect(response).to have_http_status(:unprocessable_content)
                expect(assigns(:transaction).errors.full_messages).to include("Amount must be greater than 0")
            end
        end

          context "with invalid parameters" do
            it "does not create a new transaction and renders :new" do
                expect {
                    post :create, params: { transaction: { amount: nil, description: nil, type: "CreditTransaction" } }
                }.not_to change(Transaction, :count)
                json_response = JSON.parse(response.body)
                expect(json_response["errors"]).to include("Amount is not a number", "Description can't be blank")
                expect(response).to have_http_status(:unprocessable_content)
                expect(assigns(:transaction).errors.full_messages).to include("Amount is not a number", "Description can't be blank")
            end
          end
      end

      context "when creating a debit transaction" do
          context "with valid parameters" do
            it "creates a new transaction and redirects" do
                expect {
                    post :create, params: { transaction: { amount: 50, description: "New Debit Transaction", type: "DebitTransaction"} }
                }.to change(Transaction, :count).by(1)
                expect(response).to have_http_status(:success)
                parsed_response = JSON.parse(response.body)
                expect(parsed_response.keys).to include("transaction_id", "amount", "type", "created_at", "updated_at")
                expect(parsed_response["amount"]).to eq(50)
            end
          end

          context "with invalid parameters" do
            it "does not create a new transaction and renders :new" do
                expect {
                    post :create, params: { transaction: { amount: nil, description: "", type: "DebitTransaction" } }
                }.not_to change(Transaction, :count)
                expect(response).to have_http_status(:unprocessable_content)
            end
          end
      end

      context "when creating a transfer transaction" do
          context "with valid parameters" do
              it "creates a new transaction and redirects" do
                  expect {
                      post :create, params: { transaction: { amount: 50, description: "New Transfer Transaction", type: "TransferTransaction", receiver_id: receiver.id } }
                  }.to change(Transaction, :count).by(1)
                  expect(response).to have_http_status(:success)
                  parsed_response = JSON.parse(response.body)
                  expect(parsed_response.keys).to include("transaction_id", "amount", "type", "created_at", "updated_at")
              end
          end

          context "with invalid parameters" do
              it "does not create a new transaction and renders :new" do
                  expect {
                      post :create, params: { transaction: { amount: nil, description: "", type: "TransferTransaction" } }
                  }.not_to change(Transaction, :count)
                  expect(response).to have_http_status(:unprocessable_content)
              end
          end

          context "with zero balance parameters" do
            let(:debit_transaction)  {create(:debit_transaction, amount: 900, description: "Test Debit", user: user) }
            it "does not create a new transaction and renders :new" do
                expect {
                    post :create, params: { transaction: { amount: 5, description: "verifying again", type: "TransferTransaction" , receiver_id: receiver.id} }
                    # NOTE need to add status in transaction even though not changing balance
            }.not_to change(Transaction, :count)
                expect(response).to have_http_status(:unprocessable_content)
                expect(assigns(:transaction).errors.full_messages).to include("Insufficient balance to complete the transaction")
            end
        end
      end
  end
end