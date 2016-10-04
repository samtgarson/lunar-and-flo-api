module V1
  class CheckInsController < ApplicationController
    def create
      if result.success?
        render json: result.check_in
      else
        render(
          json: { errors: ['Could not process symptoms'], invalid_ids: result.errors[:failed_symptoms] },
          status: :unprocessable_entity
        )
      end
    end

    def index
      paginate json: user.check_ins
    end

    def show
      render json: check_in
    end

    private

      def check_in
        CheckIn.find(params[:id])
      end

      def result
        @result ||= CheckIns::Process.call check_in_params.merge(user: user)
      end

      def check_in_params
        params.permit(:lat, :lng, symptom_ids: [])
      end
  end
end
