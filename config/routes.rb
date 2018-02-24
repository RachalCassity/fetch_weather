Rails.application.routes.draw do
  root to: "weather_snapshots#index"

  resources :weather_snapshots
end
