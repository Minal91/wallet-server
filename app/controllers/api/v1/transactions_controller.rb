module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_transaction, only: %i[update show]

      def index
        @transactions = current_user.transactions&.order(created_at: :desc)&.to_a || []
      end

      def show
        if @transaction
          render json: @transaction, status: :ok
        else
          render json: { error: 'Transaction not found' }, status: :not_found
        end
      end
    
      def create
        @transaction = current_user.transactions.new(transaction_params)
        if @transaction.valid? && @transaction.save
          render json: @transaction, status: :created
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def update
        if @transaction.valid? && @transaction.update(transaction_params)
          render json: @transaction, status: :ok
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:amount, :description, :type, :receiver_id)
      end

      def set_transaction
        @transaction = Transaction.find_by(id: params[:id])
        unless @transaction
          render json: { error: 'Transaction not found' }, status: :not_found
        end
      end
    end
  end
end