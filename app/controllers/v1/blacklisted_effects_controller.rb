class V1::BlacklistedEffectsController < ApplicationController
  def index
    paginate json: user.blacklisted_effects
  end
end
