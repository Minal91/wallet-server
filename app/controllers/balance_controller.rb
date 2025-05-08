class BalanceController < ApplicationController
  before_action :authenticate_user!
  # GET /balances/1

  def details
    @balance = current_user.balance
    respond_to do |format|
      format.json { render json: @balance }
      format.html { render :show }
    end
  end
end