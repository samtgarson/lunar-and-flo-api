class V1::BlacklistController < ApplicationController
  def index
    paginate json: user.blacklisted_effects
  end
end
