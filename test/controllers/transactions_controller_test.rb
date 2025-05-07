require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get history" do
    get transactions_history_url
    assert_response :success
  end
end
