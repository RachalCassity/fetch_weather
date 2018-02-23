Rails.application.routes.draw do
  root to: "weather_data#index"

  resources :weather_data
end
