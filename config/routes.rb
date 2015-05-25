Rails.application.routes.draw do
  root to: 'libraries#index'
  resources :libraries
end
