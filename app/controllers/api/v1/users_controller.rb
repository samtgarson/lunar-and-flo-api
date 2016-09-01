module Api::V1
  class UsersController < ApplicationController
    def show
      render json: user
    end

    def update
      if user.update(user_params)
        render json: user
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    delegate :destroy, to: :user

    private

      def user
        @user ||= params[:id] == 'me' ? current_user : User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email)
      end
  end
end
