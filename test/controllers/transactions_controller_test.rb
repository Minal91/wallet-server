require "test_helper"

class TransactionsControllerTest < ::ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = create(:user)
    @receiver = create(:user)
    @credit_transaction = create(:credit_transaction, amount: 1000, description: "Test Credit", user: @user)
    @debit_transaction = create(:debit_transaction, amount: 10, description: "Test Debit", user: @user)
    @transfer_transaction = create(:transfer_transaction, sender: @user, receiver: @receiver, amount: 100, description: "Test Transfer", user: @user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @user
  end

  def test_index
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
    assert_includes assigns(:transactions), @credit_transaction
    assert_includes assigns(:transactions), @debit_transaction
    assert_includes assigns(:transactions), @transfer_transaction
  end

  def test_should_create_credit_transaction
    assert_difference('Transaction.count') do
      post :create, params: { transaction: { amount: 50, description: "New Credit Transaction", type: "CreditTransaction" } }, as: :json
    end
    assert_response :found
  end

  # def test_should_not_create_transaction_with_zero_amount
  #   assert_no_difference('Transaction.count') do
  #     post :create, params: { transaction: { amount: 0, description: "New Credit Transaction", type: "CreditTransaction" } }
  #   end
  #   assert_response :unprocessable_entity
  # end

  def test_should_handle_concurrent_transactions_gracefully
    threads = []
    2.times do
      threads << Thread.new do
        Rails.application.executor.wrap do
          post :create, params: { transaction: { amount: 50, description: "New Credit Transaction", type: "CreditTransaction" } }
        end
      end
    end

    threads.each(&:join)

    assert_response :found # Assuming the controller handles this case and returns a conflict status.
  end
end
