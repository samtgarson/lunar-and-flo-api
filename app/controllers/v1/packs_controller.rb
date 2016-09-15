class V1::PacksController < ApplicationController
  def index
    paginate json: user.packs, per_page: 3, include: 'effects, effects.*'
  end

  def show
    render json: pack, include: 'effects, effects.*'
  end

  private

    def pack
      params[:id] == 'latest' ? user.latest_pack : Pack.find(params[:id])
    end
end
