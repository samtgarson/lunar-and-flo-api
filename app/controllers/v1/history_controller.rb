class V1::HistoryController < ApplicationController
  def index
    if result.success?
      render json: serialized_history
    else
      render json: result.errors
    end
  end

  private

    def result
      @result ||= UserHistory.call(user: user, from: from, to: to)
    end

    def serialized_history
      history.each { |k, v| history[k] = CheckInSerializer.new(v) if v }
    end

    def history
      @history ||= result.history
    end

    def from
      @from ||= params[:from] || 1.month.ago
    end

    def to
      @to ||= params[:to] || Time.current
    end
end
