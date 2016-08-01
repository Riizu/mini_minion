Rails.application.routes.draw do
  match '*all', to: "application#preflight", via: [:options]

  get 'request_token', to: "token#request_token"
  get 'access_token', to: "token#access_token"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :status, only: [:index]
      resources :minion, only: [:index]
      
      get 'current_user', to: "current_user#index"
    end
  end
end
