class BalanceController < ApplicationController
  before_action :set_balance, only: %i[show]
  before_action :authenticate_user!
  # GET /balances/1

  def show
    @user = current_user
    @balance = @user.balance
    format.json { render json: @balance }
    format.html { render :show }
  end
end