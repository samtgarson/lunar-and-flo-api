Rails.application.routes.draw do
  root to: 'application#home'
  devise_for :users
  get :heartbeat, to: 'application#heartbeat'
  post 'auth' => 'authentication#authenticate_user'

  mount ForestLiana::Engine => '/forest'

  constraints subdomain: 'api', defaults: { format: :json } do
    scope module: 'api' do
      namespace :v1 do
        resources :users, except: [:create]
      end
    end
  end
end
