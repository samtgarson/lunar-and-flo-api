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
      @result ||= Users::History.call(user: user, to: before, from: before - 1.month + 1.day)
    end

    def serialized_history
      history.each { |k, v| history[k] = CheckInSerializer.new(v) if v }
    end

    def history
      @history ||= result.history
    end

    def before
      @before ||= (params[:before] || Time.current).to_date
    end
end
