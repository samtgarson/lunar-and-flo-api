Rails.application.routes.draw do
  get :heartbeat, to: 'application#heartbeat'

  mount ForestLiana::Engine => '/forest'
  constraints subdomain: 'api', defaults: {format: :json} do
    scope module: 'api' do
      namespace :v1 do
        resources :users, except: [:create]
      end
    end
  end
end
