Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  constraints subdomain: 'api', defaults: {format: :json} do
    scope module: 'api' do
      namespace :v1 do
        resources :users
      end
    end
  end
end
