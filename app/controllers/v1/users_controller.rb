module V1
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

    def create
      if create_service.success?
        render json: create_service.user, status: create_status
      else
        render json: { errors: create_service.errors }, status: :unprocessable_entity
      end
    end

    delegate :destroy, to: :user

    private

      def user_params
        params.permit(:name, :email, :device_id)
      end

      def create_service
        @create_service ||= Users::Create.call(user_params)
      end

      def create_status
        create_service.already_existing ? 200 : 201
      end
  end
end
