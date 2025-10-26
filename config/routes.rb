Rails.application.routes.draw do
  get "comments/create"
  root "movies#index"
  resources :movies do
    resources :comments, only: [ :create ]
  end
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "/fetch_movie_data", to: "movie_data_fetcher#fetch"
end
