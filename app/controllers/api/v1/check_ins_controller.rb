module Api::V1
  class CheckInsController < ApplicationController
    def create
      if result.success?
        render json: result.check_in
      else
        render(
          json: { errors: ['Could not process symptoms'], invalid_ids: result.failed_symptoms },
          status: :unprocessable_entity
        )
      end
    end

    def index
      render json: current_user.check_ins
    end

    private

      def result
        @result ||= ProcessCheckIns.call(check_in_params)
      end

      def check_in_params
        params.permit(symptom_ids: []).merge(user_id: current_user.id)
      end
  end
end
