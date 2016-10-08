class V1::OnboardController < ApplicationController
  def create
    if result.success?
      render json: user.latest_pack
    else
      render json: result.errors
    end
  end

  private

    def result
      @result ||= Users::Onboard.call onboarding_params.merge(user: user)
    end

    def onboarding_params
      params.permit(:last_period, :cycle_length, :period_length, symptom_ids: [])
    end
end
