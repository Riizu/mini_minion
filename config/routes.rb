Rails.application.routes.draw do

  get '/request_token', to: "token#request_token"
  get '/access_token', to: "token#access_token"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :status, only: [:index]
    end
  end
end
