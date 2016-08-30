class ApplicationController < ActionController::API
  def heartbeat
    Rails.logger.info 'Heartbeat: beep boop.'
    render json: {hearbeat: 'beep boop'}, status: 200
  end
end
