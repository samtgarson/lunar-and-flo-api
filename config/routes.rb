Rails.application.routes.draw do
  root to: 'application#home'
  get :heartbeat, to: 'application#heartbeat'

  constraints subdomain: 'api', defaults: { format: :json } do
    api_version(module: 'V1', header: { name: 'Accept', value: 'application/vnd.lunarandflo.api+json; version=1' }, default: true) do
      resources :users, except: [:index] do
        resources :check_ins, only: [:create, :index, :show]
        get 'history', to: 'history#index'
        get 'blacklist', to: 'blacklist#index'
        resources :packs, only: [:show, :index]
      end
      resources :supplements, only: [:show, :index]
      resources :symptoms, only: [:show, :index]
    end
  end

  mount ForestLiana::Engine => '/forest'

  namespace :forest do
    post '/actions/new-secret-key' => 'api_clients#new_secret_key'
  end
end
