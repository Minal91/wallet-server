module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      def show
        render json: { user: current_user }
      end

      def update
        if current_user.update(user)
          render json: { message: 'Balance updated successfully' }, status: :ok
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def balance
        @balance = current_user.balance
        if @balance
          render json: { balance: @balance }, status: :ok
        else
          render json: { error: 'Balance not found' }, status: :not_found
        end
      end

      private
      
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end