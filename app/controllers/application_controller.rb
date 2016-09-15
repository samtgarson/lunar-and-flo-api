class ApplicationController < ActionController::API
  include AuthTokenHandling
  before_action :authenticate_request!, except: [:heartbeat]

  def home
    render json: { lunar_and_flo: 'welcome' }
  end

  def heartbeat
    Rails.logger.info 'Heartbeat: beep boop.'
    render json: { hearbeat: 'beep boop' }, status: 200
  end

  def user
    @user ||= user_param == 'me' ? current_user : User.find(user_param)
  end

  def user_param
    @user_param ||= params[:user_id] || params[:id]
  end
end
