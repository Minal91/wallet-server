class TransactionsController < ApplicationController
  def history
    @user = current_user
    @transactions = @user&.transactions&.order(created_at: :desc)&.to_a || []
  end
end
