FayeRailsDemo::Application.routes.draw do
  resources :chat
  root to: 'chat#index'
end
