class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[update edit show destroy]
  before_action :authenticate_user!
  def index
    @user = current_user
    @transactions = @user&.transactions&.order(created_at: :desc)&.to_a || []
  end

  def create
    @user = current_user
    @transaction = Transaction.new(transaction_params)
    @transaction.user = @user

    if @transaction.save
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transactions_path, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @transaction = Transaction.new
    @users = User.all.except(current_user)
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :type, :receiver_id)
  end

  def set_transaction
    @transaction = Transaction.find_by(id: params[:id])
  end
end
