class BalancesController < ApplicationController
  before_action :set_balance, only: %i[update, edit, transfer]
  before_action :authenticate_user!
  # GET /balances/1

  def transfer
    @balance = current_user.balance
    balance_receiver = Balance.find(params[:receiver_id])
    amount = params[:amount].to_f
    if @balance.transfer(balance_receiver, amount)  
        redirect_to @balance, notice: 'Transfer was successful.'
    else
        redirect_to @balance, alert: 'Transfer failed.'
    end
  end

  def update
    @balance = current_user.balance
    if @balance.update(balance_params)
      redirect_to @balance, notice: 'Balance was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @balance = current_user.balance
  end


  private

  # Only allow a list of trusted parameters through.
  def balance_params
    params.require(:balance).permit(:amount, :currency)
  end
end