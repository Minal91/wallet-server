class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[update edit show]
  before_action :authenticate_user!
  def index
    @transactions = current_user.transactions&.order(created_at: :desc)&.to_a || []
  end

  def create
    
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.valid? && @transaction.save
      redirect_to transactions_path, notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_content, errors: @transaction.errors.full_messages
    end
  end

  def update
    if @transaction.valid? && @transaction.update(transaction_params)
      redirect_to transactions_path, notice: 'Transaction was successfully updated.'
    else
      render :edit, status: :unprocessable_content, errors: @transaction.errors.full_messages
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

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :type, :receiver_id)
  end

  def set_transaction
    @transaction = Transaction.find_by(id: params[:id])
  end
end
