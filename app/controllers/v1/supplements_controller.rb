class V1::SupplementsController < ApplicationController
  def index
    paginate json: Supplement.all, include: 'effects.symptom'
  end

  def show
    render json: supplement, include: 'effects.symptom'
  end

  private

    def supplement
      Supplement.find(params[:id])
    end
end
