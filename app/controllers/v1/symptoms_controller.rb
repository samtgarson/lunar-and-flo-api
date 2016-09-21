class V1::SymptomsController < ApplicationController
  def index
    paginate json: Symptom.all
  end

  def show
    render json: symptom
  end

  private

    def symptom
      Symptom.find(params[:id])
    end
end
