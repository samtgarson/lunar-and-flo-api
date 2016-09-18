class GenerateNewPacksJob < ApplicationJob
  queue_as :default

  class FailedInteractionError < StandardError; end

  def perform(user_id)
    @user_id = user_id

    raise FailedInteractionError, result.errors unless result.success?
  end

  private

    def result
      @result ||= GeneratePack.call(user: user)
    end

    def user
      @user ||= User.find(@user_id)
    end
end
