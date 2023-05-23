Rails.application.routes.draw do
  root 'heroes#index'
  resources :heroes
  post '/heroes/battle', to: 'heroes#battle'
end
