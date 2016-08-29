Rails.application.routes.draw do
  constraints subdomain: 'api', defaults: {format: :json} do
    scope module: 'api' do
      namespace :v1 do
        resources :users
      end
    end
  end
end
