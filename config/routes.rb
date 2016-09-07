Rails.application.routes.draw do
  root to: 'application#home'
  devise_for :users
  get :heartbeat, to: 'application#heartbeat'
  post 'auth' => 'authentication#authenticate_user'

  mount ForestLiana::Engine => '/forest'

  constraints subdomain: 'api', defaults: { format: :json } do
    api_version(module: 'V1', header: { name: 'Accept', value: 'application/vnd.lunarandflo.com; version=1' }, default: true) do
      resources :users, except: [:create, :index]
      resources :check_ins, only: [:create, :index]
    end
  end
end
